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
        var isCompleted: Bool
        
        static let example = Step(name: "Fluid Dynamics", details: "'Fisica Generale 1' by Giorgio Rosati. Pages 44-75.")
        
        init(name: String, details: String = "", isCompleted: Bool = false) {
            id = UUID()
            self.name = name
            self.details = details
            self.isCompleted = isCompleted
        }
    }
}
