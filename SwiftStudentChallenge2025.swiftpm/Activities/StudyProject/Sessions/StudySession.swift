//
//  StudySession.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 22/02/25.
//

import Foundation
import SwiftData

@Model
class StudySession: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var startDate: Date
    var duration: TimeInterval
    var pauses: [Pause]?
    
    var project: StudyProject
    
    init(startDate: Date = .now, duration: TimeInterval, pauses: [Pause]?, project: StudyProject) {
        id = UUID()
        
        self.startDate = startDate
        self.duration = duration
        self.pauses = pauses
        self.project = project
    }
    
    init(startDate: Date = .now, duration: TimeInterval, allowPausing: Bool, project: StudyProject) {
        id = UUID()
        pauses = allowPausing ? [] : nil
        
        self.startDate = startDate
        self.duration = duration
        self.project = project
    }
    
    @MainActor static let example = StudySession(duration: 60*60, allowPausing: true, project: .example)
    
    var timeProgress: TimeInterval {
        let timeFromStart = min(Date.now.timeIntervalSince(startDate), duration)
        guard let pauses, !pauses.isEmpty else { return timeFromStart }
        
        let pauseDuration = pauses
            .map(\.duration)
            .compactMap { $0 }
            .reduce(0, +)
        
        if let pauseIndex = currentPauseIndex() {
            return min(pauses[pauseIndex].startDate.timeIntervalSince(startDate) - pauseDuration, duration)
        } else {
            return min(timeFromStart - pauseDuration, duration)
        }
    }
    
    var timeRemaining: TimeInterval {
        duration - timeProgress
    }
    
    var progress: Double {
        timeProgress / duration
    }
    
    func currentPauseIndex() -> Int? {
        pauses?.firstIndex { $0.endDate == nil }
    }
    
    var isPaused: Bool {
        currentPauseIndex() != nil
    }
    
    func pause() {
        guard pauses !=  nil else { return }
        
        let pause = Pause()
        pauses?.append(pause)
    }
    
    func resume(at date: Date = .now) {
        guard let index = currentPauseIndex() else { return }
        pauses?[index].endDate = date
    }
    
    func cancel() {
        let now = Date.now
        duration = Date.now.timeIntervalSince1970 - now.timeIntervalSince1970
        resume(at: now)
        
        project.currentSessionID = nil
    }
}
