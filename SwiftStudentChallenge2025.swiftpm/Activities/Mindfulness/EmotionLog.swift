//
//  EmotionLog.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 08/02/25.
//

import Foundation
import SwiftData

// Emotion or MOOD?

// Mood is over a longer time
// Emotion is connected to the moment

// I could do Emotion every time you start studying and then showing an overall mood regarding the task

@Model
final class EmotionLog: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var emotion: Emotion
    var date: Date
    
    var project: StudyProject
    
    init(emotion: Emotion, project: StudyProject) {
        id = UUID()
        date = .now
        
        self.emotion = emotion
        self.project = project
    }
}
