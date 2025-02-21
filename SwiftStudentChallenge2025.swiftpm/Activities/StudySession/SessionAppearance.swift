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
    let sessionAppearance: StudySession.Appearance
    
    var titleFontDesign: Font.Design {
        switch sessionAppearance.titleFont {
        case .rounded: .rounded
        case .serif: .serif
        default: .default
        }
    }
    
    var titleFontWidth: Font.Width {
        switch sessionAppearance.titleFont {
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
    func fontStyling(for sessionAppearance: StudySession.Appearance) -> some View {
        modifier(SessionFontStylingModifier(sessionAppearance: sessionAppearance))
    }
}
