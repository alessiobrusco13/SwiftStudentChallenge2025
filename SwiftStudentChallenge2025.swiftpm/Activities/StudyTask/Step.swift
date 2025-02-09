//
//  StudyStep.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 08/02/25.
//

import Foundation

extension StudyTask {
    struct Step: Codable, Identifiable {
        let id: UUID
        var name: String
        var details: String
        var completed: Bool
        
        init(name: String, details: String = "", completed: Bool = false) {
            id = UUID()
            self.name = name
            self.details = details
            self.completed = completed
        }
    }
}
