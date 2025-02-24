//
//  ProjectAppearance.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

extension StudyProject {
    struct Appearance: Codable {
        enum TitleFont: Codable, CaseIterable {
            case regular, expanded, rounded, serif
        }
        
        var titleFont = TitleFont.regular
        var itemColorRepresentation = ColorRepresentation(of: .black)
    }
}

fileprivate struct ProjectFontStylingModifier: ViewModifier {
    let projectAppearance: StudyProject.Appearance
    
    var titleFontDesign: Font.Design {
        switch projectAppearance.titleFont {
        case .rounded: .rounded
        case .serif: .serif
        default: .default
        }
    }
    
    var titleFontWidth: Font.Width {
        switch projectAppearance.titleFont {
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
    func fontStyling(for projectAppearance: StudyProject.Appearance) -> some View {
        modifier(ProjectFontStylingModifier(projectAppearance: projectAppearance))
    }
}
