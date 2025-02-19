//
//  StepRowView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 19/02/25.
//

import SwiftUI

// When i tap on the text it turns into a textfield

struct StepRowView: View {
    @Binding var step: StudySession.Step
    @Binding var selection: StudySession.Step?
    
    var isSelected: Bool {
        guard let selection else { return false }
        return selection.id == step.id
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                withAnimation {
                    step.completed.toggle()
                }
            } label: {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.secondary, lineWidth: 2)
                    .overlay {
                        if step.completed {
                            Image(systemName: "checkmark")
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                                .font(.caption)
                        }
                    }
            }
            .buttonStyle(.pressable)
            .frame(width: 20, height: 20)
            .padding(.top, isSelected ? 3 : 0)
            
            VStack(alignment: .leading, spacing: 5) {
                Button {
                    selection = step
                } label: {
                    HStack {
                        Text(step.name)
                            .font(isSelected ? .title2 : .body)
                            .bold()
                        
                        if !step.details.isEmpty {
                            Image(systemName: "text.justify.left")
                                .bold()
                        }
                    }
                }
                .disabled(step.details.isEmpty || isSelected)
                .buttonStyle(.passthrough)
                
                if isSelected {
                    Text(step.details)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.prominentGlass.opacity(isSelected ? 1 : 0))
                .onTapGesture {
                    // To make it so that in the 'StepsView', when you tap on the background it doesn't deselect.
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var step = StudySession.Step.example
    @Previewable @State var selection: StudySession.Step? = nil
    
    ZStack {
        Color.blue
            .ignoresSafeArea()
        
        Button {
            selection = nil
        } label: {
            Rectangle()
                .fill(.black.opacity(selection == nil ? 0 : 0.2))
                .ignoresSafeArea()
        }
        .buttonStyle(.passthrough)
        .disabled(selection == nil)
        
        StepRowView(step: $step, selection: $selection)
            .preferredColorScheme(.dark)
    }
    .animation(.default.speed(2), value: selection?.id)
}
