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
    
    var body: some View {
        NavigationLink(value: session) {
            RoundedRectangle(cornerRadius: 40)
                .fill(itemColor.gradient)
                .frame(maxWidth: 370)
                .frame(height: 390)
                .overlay(alignment: .bottom) {
                    Text(session.title)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .fontWidth(titleFontWidth)
                        .fontDesign(titleFontDesign)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.glass, in: .rect(cornerRadius: 20))
                        .padding(20)
                }
                .overlay(alignment: .topTrailing) {
                    if session.completed {
                        Image(systemName: "checkmark")
                            .bold()
                            .padding(10)
                            .background(.glass, in: .circle)
                            .padding(20)
                    }
                }
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
    .preferredColorScheme(.dark)
}
