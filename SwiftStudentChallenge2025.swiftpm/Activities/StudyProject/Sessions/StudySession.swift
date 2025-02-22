//
//  StudySession.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 22/02/25.
//

import Foundation
import SwiftData

@Model class StudySession: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var startDate: Date
    var duration: TimeInterval
    var isPaused: Bool
    var pauses: [Pause]?
    
    var project: StudyProject
    
    init(startDate: Date = .now, duration: TimeInterval, isPaused: Bool = false, pauses: [Pause]?, project: StudyProject) {
        self.id = UUID()
        self.startDate = startDate
        self.duration = duration
        self.isPaused = isPaused
        self.pauses = pauses
        self.project = project
    }
}
