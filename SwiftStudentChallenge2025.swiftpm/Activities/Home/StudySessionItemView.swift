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
    
    var deadlineText: String? {
        guard let daysUntilDeadline = Calendar.current.dateComponents([.day], from: .now, to: session.endDate).day else {
            return nil
        }
        
        guard daysUntilDeadline > 0 else {
            return "Past due"
        }
        
        guard daysUntilDeadline < 5 else {
            return nil
        }
        
        switch daysUntilDeadline {
        case 0: return "Due Today"
        case 1: return "Due Tomorrow"
        default: return "Due in \(daysUntilDeadline) days"
        }
        
    }
    
    var body: some View {
        NavigationLink(value: session) {
            RoundedRectangle(cornerRadius: 40)
                .fill(itemColor.gradient)
                .frame(maxWidth: 370)
                .padding(.horizontal)
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
                        .background(.glass, in: .capsule)
                        .padding(20)
                        .padding(.horizontal)
                }
                .overlay(alignment: .topTrailing) {
                    if session.completed {
                        icon(for: "checkmark")
                    } else if let deadlineText {
                        Text(deadlineText)
                            .font(.subheadline.bold().smallCaps())
                            .fontDesign(.rounded)
                            .padding(12)
                            .background(.glass, in: .capsule)
                            .padding(20)
                            .padding(.horizontal)
                        
                    }
                }
                .overlay(alignment: .topLeading) {
                    if let symbol = session.symbol {
                        icon(for: symbol.rawValue)
                    }
                }
        }
        .buttonStyle(.pressable)
    }
    
    func icon(for symbol: String) -> some View {
        Image(systemName: symbol)
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
            .bold()
            .padding(12)
            .background(.glass, in: .circle)
            .padding(20)
            .padding(.horizontal)
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
