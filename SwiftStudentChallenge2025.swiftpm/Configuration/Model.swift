//
//  Model.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 07/02/25.
//

import Foundation
import SwiftData

@MainActor
@Observable
final class Model {
    let container: ModelContainer
    private let modelContext: ModelContext
    let notificationManager = NotificationManager()
    
    var shouldShowWelcomeScreen = true
    
    static let hasOnboardedKey = "hasOnboarded"
    static let activeProjectIDKey = "activeProjectID"
    
    static let preview = {
        let model = Model(inMemory: true)
        
        do {
            try model.generateSampleData()
        } catch {
            fatalError("Failed to create sample data.")
        }
        
        return model
    }()
    
    init(inMemory: Bool = false) {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
        let container = try! ModelContainer(for: StudyProject.self, configurations: configuration)
        
        self.container = container
        self.modelContext = container.mainContext
    }
    
    func generateSampleData() throws {
        let configureProject: (StudyProject, Bool) -> Void = { project, isCompleted in
            let stepNames = ["Research", "Drafting", "Revision", "Final Touches", "Submission"]
            let stepDetails = [
                "Gather key materials and take notes",
                "Outline the structure and start writing",
                "Refine arguments and correct mistakes",
                "Polish formatting and citations",
                "Submit the final work"
            ]
            
            let steps = zip(stepNames, stepDetails).enumerated().map { index, pair in
                StudyProject.Step(name: pair.0, details: pair.1, isCompleted: isCompleted)
            }
            
            project.steps = steps
            project.symbol = StudyProject.Symbol.allCases.randomElement()!
            project.appearance.itemColorRepresentation = .random()
            project.appearance.titleFont = StudyProject.Appearance.TitleFont.allCases.randomElement()!
        }

        let activeProjects = [
            ("History Essay", 5),
            ("Math Problem Set", 3),
            ("Biology Lab Report", 7)
        ]
        
        for (title, daysUntilDue) in activeProjects {
            let project = StudyProject(
                title: title,
                endDate: Calendar.current.date(byAdding: .day, value: daysUntilDue, to: .now) ?? .now
            )
            
            configureProject(project, false)
            modelContext.insert(project)
        }

        let completedProjects = [
            ("Physics Homework", -12),
            ("Literature Analysis", -15),
            ("Computer Science Project", -9)
        ]
        
        for (title, daysAgoCompleted) in completedProjects {
            let project = StudyProject(
                title: title,
                endDate: Calendar.current.date(byAdding: .day, value: daysAgoCompleted, to: .now) ?? .now
            )
            
            configureProject(project, true)
            modelContext.insert(project)
        }

        try modelContext.save()
    }
    
    func lastEmotionLog(for project: StudyProject) -> EmotionLog? {
        project.emotionLogs.sorted { $0.date < $1.date }.last
    }
    
    func lastEmotionLog(in context: ModelContext) -> EmotionLog? {
        let fetchDescriptor = FetchDescriptor<EmotionLog>(sortBy: [SortDescriptor(\.date)])
        
        do {
            let logs = try context.fetch(fetchDescriptor)
            return logs.last
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func log(_ emotion: Emotion, for project: StudyProject, in modelContext: ModelContext) {
        let log = EmotionLog(emotion: emotion, project: project)
        modelContext.insert(log)
        project.emotionLogs.append(log)
    }
    
    func startSession(for project: StudyProject, duration: TimeInterval, allowPausing: Bool, in modelContext: ModelContext) {
        let session = StudySession(duration: duration, allowPausing: allowPausing, project: project)
        modelContext.insert(session)
        
        project.sessions.append(session)
        project.currentSessionID = session.id
        
        UserDefaults.standard.set(project.id.uuidString, forKey: Model.activeProjectIDKey)
    }
    
    func completeSession(for project: StudyProject) {
        project.currentSessionID = nil
        UserDefaults.standard.set(nil, forKey: Model.activeProjectIDKey)
    }
}

// TODO: Handle settings
