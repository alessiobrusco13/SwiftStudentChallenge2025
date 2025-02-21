//
//  StepRowView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 19/02/25.
//

import SwiftUI

// – [X] When i tap on the text it turns into a textfield

struct StepRowView<DeleteButton: View>: View {
    @Binding var step: StudySession.Step
    @Binding var selection: StudySession.Step?
    let deleteButton: (StudySession.Step) -> DeleteButton
    
    @State private var tappedName = false
    @State private var graphicCompletedState: Bool
    @FocusState private var nameFieldFocused: Bool
    
    var isSelected: Bool {
        guard let selection else { return false }
        return selection.id == step.id
    }
    
    init(
        step: Binding<StudySession.Step>,
        selection: Binding<StudySession.Step?>,
        @ViewBuilder deleteButton: @escaping (_ step: StudySession.Step) -> DeleteButton
    ) {
        _step = step
        _selection = selection
        _graphicCompletedState = State(initialValue: step.completed.wrappedValue)
        self.deleteButton = deleteButton
    }
    
    var body: some View {
        HStack(alignment: .top) {
            completeButton
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    stepTitle
                    
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
            
            // Only shows delete button for the current selection
            if isSelected {
                Spacer()
                deleteButton(step)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: isSelected) {
            guard !isSelected else { return }
            tappedName = false
        }
    }
    
    var completeButton: some View {
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
            RoundedRectangle(cornerRadius: 8)
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
        .padding(.top, isSelected ? 4 : 0)

    }
    
    @ViewBuilder var stepTitle: some View {
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
        
        StepRowView(step: $step, selection: $selection) { _ in }
            .preferredColorScheme(.dark)
    }
    .animation(.default.speed(2), value: selection?.id)
}
