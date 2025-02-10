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
        // It should crash if it can't create a container.
        let container = try! ModelContainer(for: StudySession.self, configurations: configuration)
        
        self.container = container
        self.modelContext = container.mainContext
    }
    
    func generateSampleData() throws {
        for i in 0..<3 {
            let goal = StudySession(
                title: "Test Goal \(i)",
                endDate: Calendar.current.date(byAdding: .day, value: 10 + i, to: .now) ?? .now
            )
            
            let steps = (0..<5).map { StudySession.Step(name: "Step \($0)", details: "Read chapter \($0+1)") }
            goal.steps = steps
            
            modelContext.insert(goal)
        }
        
        try modelContext.save()
    }
}

// TODO: Handle settings
