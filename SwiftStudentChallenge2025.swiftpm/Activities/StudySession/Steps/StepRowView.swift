//
//  StepRowView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 19/02/25.
//

import SwiftUI

// – [X] When i tap on the text it turns into a textfield

struct StepRowView: View {
    @Binding var step: StudySession.Step
    @Binding var selection: StudySession.Step?
    
    @State private var tappedName = false
    @FocusState private var nameFieldFocused: Bool
    
    @State private var graphicCompletedState: Bool
    
    var isSelected: Bool {
        guard let selection else { return false }
        return selection.id == step.id
    }
    
    var completedButtonDisabled: Bool {
        if selection != nil {
            guard isSelected else { return true }
        }
        
        return false
    }
    
    init(step: Binding<StudySession.Step>, selection: Binding<StudySession.Step?>) {
        _step = step
        _selection = selection
        _graphicCompletedState = State(initialValue: step.completed.wrappedValue)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                Task { @MainActor in
                    withAnimation {
                        graphicCompletedState.toggle()
                        selection = nil
                    }
                    
                    try? await Task.sleep(for: .seconds(0.5))
                    
                    withAnimation {
                        step.completed = graphicCompletedState
                    }
                }
            } label: {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.secondary, lineWidth: 2)
                    .overlay {
                        if graphicCompletedState {
                            Image(systemName: "checkmark")
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                                .font(.caption)
                        }
                    }
            }
            .buttonStyle(.pressable)
            .frame(width: 20, height: 20)
            .disabled(completedButtonDisabled)
            .padding(.top, isSelected ? 4 : 0)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if !tappedName {
                        Text(step.name)
                            .font(isSelected ? .title2 : .body)
                            .bold()
                            .padding(.vertical, isSelected ? 1 : 0)
                    } else {
                        TextField("Step name", text: $step.name)
                            .font(isSelected ? .title2 : .body)
                            .bold()
                            .focused($nameFieldFocused)
                    }
                    
                    if !step.details.isEmpty && !tappedName {
                        Image(systemName: "text.justify.left")
                            .bold()
                    }
                }
                .contentShape(.rect)
                .onTapGesture {
                    if !isSelected {
                        selection = step
                    } else {
                        tappedName = true
                        nameFieldFocused = true
                    }
                }
                
                if isSelected {
                    TextField("Details…", text: $step.details, axis: .vertical)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: isSelected) {
            guard !isSelected else { return }
            tappedName = false
        }
    }
}

#Preview {
    @Previewable @State var step = StudySession.Step.example
    @Previewable @State var selection: StudySession.Step? = nil
    
    ZStack {
        Color.green
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
