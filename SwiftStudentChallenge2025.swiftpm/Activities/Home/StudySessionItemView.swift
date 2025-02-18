//
//  StudySessionItemView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

// [X] Show deadline but only when it is close enough to the present day, otherwise it might case further procrastination. [Paper](https://typeset.io/papers/on-the-interaction-of-memory-and-procrastination-4kckmuyj2u)

struct StudySessionItemView: View {
    let session: StudySession
    let namespace: Namespace.ID
    
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
        RoundedRectangle(cornerRadius: 40)
            .fill(itemColor.gradient.opacity(0.6))
            .frame(maxWidth: 370)
            .frame(height: 390)
            .matchedTransitionSource(id: session.id, in: namespace)
            .overlay(alignment: .bottom) {
                Text(session.title)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .fontStyling(for: session)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.glass, in: .capsule)
                    .padding(20)
                    .colorScheme(.dark)
            }
            .overlay(alignment: .topTrailing) {
                if session.completed {
                    icon(for: "checkmark")
                } else if let deadlineText {
                    Text(deadlineText)
                        .foregroundStyle(.white)
                        .font(.subheadline.bold().smallCaps())
                        .fontDesign(.rounded)
                        .padding(12)
                        .background(.glass, in: .capsule)
                        .padding(20)
                        .colorScheme(.dark)
                    
                }
            }
            .overlay(alignment: .topLeading) {
                if let symbol = session.symbol {
                    icon(for: symbol.rawValue)
                }
            }
            .compositingGroup()
    }
    
    private func icon(for symbol: String) -> some View {
        Image(systemName: symbol)
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
            .bold()
            .padding(12)
            .background(.glass, in: .circle)
            .padding(20)
            .colorScheme(.dark)
    }
}

#Preview {
    @Previewable @Namespace var namespace
    
    Previewer(for: StudySession.self) {
        StudySessionItemView(session: .example, namespace: namespace)
    } contextHandler: { context in
        context.insert(StudySession.example)
    }
    .preferredColorScheme(.dark)
}
