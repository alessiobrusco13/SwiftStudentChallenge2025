//
//  Pause.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 22/02/25.
//

import Foundation

extension StudySession {
    struct Pause: Codable {
        let startDate: Date
        let endDate: Date?
        
        var duration: TimeInterval? {
            guard let endDate else { return nil }
            return endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
        }
    }
}
