//
//  StudySessionItemView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

// [] Show deadline but only when it is close enough to the present day, otherwise it might case further procrastination. [Paper](https://typeset.io/papers/on-the-interaction-of-memory-and-procrastination-4kckmuyj2u)

struct StudySessionItemView: View {
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
    
    var itemColor: Color {
        session.appearance.itemColorRepresentation.color
    }
    
    var isBackgroundLight: Bool {
        itemColor.relativeLuminance > 0.5
    }
    
    var body: some View {
        NavigationLink(value: session) {
            ZStack {
                RoundedRectangle(cornerRadius: 36)
                    .foregroundStyle(itemColor.gradient)
                
                Text(session.title)
                    .foregroundStyle(isBackgroundLight ? .black : .white)
                    .font(.title)
                    .fontWeight(.heavy)
                    .fontDesign(titleFontDesign)
                    .fontWidth(titleFontWidth)
                    .frame(maxWidth: .infinity, maxHeight: . infinity, alignment: .bottomLeading)
                    .padding(36)
                
                if let symbol = session.symbol {
                    Image(systemName: symbol.rawValue)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 156, height: 156)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.horizontal, 36)
                        .padding(.vertical, 26)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 320)
            .padding(.horizontal)
        }
        .buttonStyle(.pressable)
    }
}

#Preview {
    Previewer(for: StudySession.self) {
        StudySessionItemView(session: .example)
    } contextHandler: { context in
        context.insert(StudySession.example)
    }
}
