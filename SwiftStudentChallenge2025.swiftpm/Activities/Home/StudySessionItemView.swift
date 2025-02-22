//
//  StudyProjectItemView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

// [X] Show deadline but only when it is close enough to the present day, otherwise it might case further procrastination. [Paper](https://typeset.io/papers/on-the-interaction-of-memory-and-procrastination-4kckmuyj2u)

struct StudyProjectItemView: View {
    let project: StudyProject
    let namespace: Namespace.ID
    
    private var itemColor: Color {
        project.appearance.itemColorRepresentation.color
    }
    
    private var deadlineString: String? {
        guard let daysUntilDeadline = Calendar.current.dateComponents([.day], from: .now, to: project.endDate).day else {
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
            .matchedTransitionSource(id: project.id, in: namespace)
            .overlay(alignment: .bottom, content: titleView)
            .overlay(alignment: .topTrailing) {
                if project.completed {
                    icon(for: "checkmark")
                } else if let deadlineString {
                    deadlineView(deadlineString)
                }
            }
            .overlay(alignment: .topLeading) {
                if let symbol = project.symbol {
                    icon(for: symbol.rawValue)
                }
            }
            .compositingGroup()
    }
    
    private func titleView() -> some View {
        Text(project.title)
            .foregroundStyle(.white)
            .font(.title3)
            .fontWeight(.bold)
            .fontStyling(for: project.appearance)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.glass, in: .capsule)
            .padding(20)
            .colorScheme(.dark)
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
    
    private func deadlineView(_ deadline: String) -> some View {
        Text(deadline)
            .foregroundStyle(.white)
            .font(.subheadline.bold().smallCaps())
            .fontDesign(.rounded)
            .padding(12)
            .background(.glass, in: .capsule)
            .padding(20)
            .colorScheme(.dark)
    }
}

#Preview {
    @Previewable @Namespace var namespace
    
    Previewer(for: StudyProject.self) {
        StudyProjectItemView(project: .example, namespace: namespace)
    } contextHandler: { context in
        context.insert(StudyProject.example)
    }
    .preferredColorScheme(.dark)
}
