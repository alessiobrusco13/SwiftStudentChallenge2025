//
//  StudyTask.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 07/02/25.
//

import Foundation
import SwiftData

@Model
final class StudyTask: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var title: String
    var details: String
    var completed: Bool
    var steps: [Step]
    
    var startDate: Date
#warning("It's important the user doesn't change the end date lightly. Be sure to prompt the user about it.")
    var endDate: Date
    
    init(title: String, details: String = "", startDate: Date = .now, endDate: Date, completed: Bool = false) {
        id = UUID()
        steps = []
        
        self.title = title
        self.details = details
        self.startDate = startDate
        self.endDate = endDate
        self.completed = completed
    }
    
    @MainActor static let example =  StudyTask(title: "Newtonian mechanics exam", endDate: .now.addingTimeInterval(2*24*60*60))
}
