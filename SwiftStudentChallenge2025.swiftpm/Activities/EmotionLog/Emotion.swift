//
//  Emotion.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 08/02/25.
//

import Foundation

enum Emotion: CaseIterable, Codable {
    case anxiety
    case frustration
    case neutrality
    case hopefulness
    case motivation
    
    // Using the HealthKit standard. A value from -1 to 1, reporting how good or bad an emotion is.
    var valence: Double {
        switch self {
        case .anxiety: -0.8
        case .frustration: -0.4
        case .neutrality: 0
        case .hopefulness: 0.6
        case .motivation: 0.9
        }
    }
    
    var emoji: String {
        switch self {
        case .anxiety: "😰"
        case .frustration: "😤"
        case .neutrality: "😐"
        case .hopefulness: "🙂" // "🌟
        case .motivation: "🤩" // "🚀"
        }
    }
}
