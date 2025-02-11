//
//  StudySession.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 07/02/25.
//

import Foundation
import SwiftData

@Model
final class StudySession: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var title: String
    var details: String
    var completed: Bool
    var steps: [Step]
    
    var startDate: Date
#warning("It's important the user doesn't change the end date lightly. Be sure to prompt the user about it.")
    var endDate: Date
    
    var appearance: Appearance
    
    init(
        title: String,
        details: String = "",
        completed: Bool = false,
        appearance: Appearance = Appearance(),
        startDate: Date = .now,
        endDate: Date
    ) {
        id = UUID()
        steps = []
        
        self.title = title
        self.details = details
        self.completed = completed
        self.appearance = appearance
        self.startDate = startDate
        self.endDate = endDate
    }
    
    @MainActor static let example =  StudySession(title: "Newtonian mechanics exam", endDate: .now.addingTimeInterval(2*24*60*60))
}
