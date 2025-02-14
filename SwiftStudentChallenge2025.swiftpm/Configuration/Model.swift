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
    
    var shouldShowWelcomeScreen = true
    
    static let hasOnboardedKey = "hasOnboarded"
    static let currentSessionIDKey = "currentSessionID"
    
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
        let container = try! ModelContainer(for: StudySession.self, configurations: configuration)
        
        self.container = container
        self.modelContext = container.mainContext
    }
    
    func generateSampleData() throws {
        let configureSession: (StudySession) -> Void = {
            $0.steps = (0..<5).map {
                StudySession.Step(name: "Step \($0)", details: "Read chapter \($0+1)")
            }
            
            $0.symbol = StudySession.Symbol.allCases.randomElement()!
            $0.appearance.itemColorRepresentation = .random()
            $0.appearance.titleFont = StudySession.Appearance.TitleFont.allCases.randomElement()!
            
        }
        
        for i in 0..<3 {
            let session = StudySession(
                title: "Test Session \(i)",
                endDate: Calendar.current.date(byAdding: .day, value: 4 + i, to: .now) ?? .now
            )
            
            configureSession(session)
            modelContext.insert(session)
        }
        
        for i in 0..<3 {
            let session = StudySession(
                title: "Completed Session \(i)",
                endDate: Calendar.current.date(byAdding: .day, value: -10 - i, to: .now) ?? .now
            )
            
            session.completed = true
            configureSession(session)
            modelContext.insert(session)
        }
        
        try modelContext.save()
    }
    
    func lastEmotionLog(for session: StudySession) -> EmotionLog? {
        session.emotionLogs.sorted { $0.date < $1.date }.last
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
    
    func shouldShowEmotionLogger(for session: StudySession, context: ModelContext) -> Bool {
        if let lastLog = lastEmotionLog(in: modelContext), (Date.now.timeIntervalSince1970 - lastLog.date.timeIntervalSince1970) < 30*60 {
            return false
        } else if let lastSessionLog = lastEmotionLog(for: session),
                  (Date.now.timeIntervalSince1970 - lastSessionLog.date.timeIntervalSince1970) < 4*60*60 {
            return false
        } else {
            return true
        }
    }
    
    func log(_ emotion: Emotion, for session: StudySession, in modelContext: ModelContext) {
        let log = EmotionLog(emotion: emotion)
        modelContext.insert(log)
        session.emotionLogs.append(log)
    }
}

// TODO: Handle settings
