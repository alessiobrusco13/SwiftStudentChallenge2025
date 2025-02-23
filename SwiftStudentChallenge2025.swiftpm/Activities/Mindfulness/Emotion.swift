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
    
    // A value ranging from -1 to 1 according Russel's "Circumplex model".
       var valence: Double {
           switch self {
           case .anxiety: -0.7
           case .frustration: -0.5
           case .neutrality: 0
           case .hopefulness: 0.6
           case .motivation: 0.8
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
