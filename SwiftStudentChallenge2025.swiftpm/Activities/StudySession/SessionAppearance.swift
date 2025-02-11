//
//  SessionAppearance.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

extension StudySession {
    struct Appearance: Codable {
        enum TitleFont: Codable, CaseIterable {
            case regular, rounded, serif, expanded
        }
        
        var titleFont = TitleFont.regular
        var itemColorRepresentation = ColorRepresentation(of: .black)
    }
}
