//
//  Pause.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 22/02/25.
//

import Foundation

extension StudySession {
    struct Pause: Codable {
        var startDate = Date.now
        var endDate: Date?
        
        var duration: TimeInterval? {
            guard let endDate else { return nil }
            return endDate.timeIntervalSince(startDate)
        }
    }
}
