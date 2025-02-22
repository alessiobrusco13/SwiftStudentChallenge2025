//
//  StudyStep.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 08/02/25.
//

import Foundation

extension StudyProject {
    struct Step: Codable, Identifiable, Equatable {
        let id: UUID
        var name: String
        var details: String
        var completed: Bool
        
        static let example = Step(name: "Fluid Dynamics", details: "'Fisica Generale 1' by Giorgio Rosati. Pages 44-75.")
        
        init(name: String, details: String = "", completed: Bool = false) {
            id = UUID()
            self.name = name
            self.details = details
            self.completed = completed
        }
    }
}
