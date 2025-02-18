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

fileprivate struct SessionFontStylingModifier: ViewModifier {
    let session: StudySession
    
    var titleFontDesign: Font.Design {
        switch session.appearance.titleFont {
        case .rounded: .rounded
        case .serif: .serif
        default: .default
        }
    }
    
    var titleFontWidth: Font.Width {
        switch session.appearance.titleFont {
        case .expanded: .expanded
        default: .standard
        }
    }
    
    func body(content: Content) -> some View {
        content
            .fontDesign(titleFontDesign)
            .fontWidth(titleFontWidth)
    }
}

extension View {
    func fontStyling(for session: StudySession) -> some View {
        modifier(SessionFontStylingModifier(session: session))
    }
}
