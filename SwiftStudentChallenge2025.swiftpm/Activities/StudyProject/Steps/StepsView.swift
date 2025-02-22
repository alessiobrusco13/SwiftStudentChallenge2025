//
//  StepsView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 19/02/25.
//

import SwiftUI

// Add a button to add steps. It adds an empty one, then it selects it and focuses it.
struct StepsView: View {
    @Binding var steps: [StudyProject.Step]
    @Binding var selection: StudyProject.Step?
    @Binding var showingAllSteps: Bool
    let appearance: StudyProject.Appearance
    
    @Namespace private var namespace
    
    private var currentStep: StudyProject.Step? {
        steps.first { $0.completed == false }
    }
    
    var body: some View {
        GroupBox {
            VStack(spacing: 20) {
                ForEach($steps) { $step in
                    stepView(step, binding: $step)
                }
            }
        } label: {
            HStack {
                HStack(spacing: 0) {
                    heading
                    
                    Spacer()
                }
                .contentShape(.containerRelative)
                .onTapGesture(perform: expandAction)
                
                Button(action: expandAction, label: expandButtonLabel)
                    .buttonBorderShape(.circle)
                    .buttonStyle(.prominentGlass)
                    .colorScheme(.light)
            }
        }
        .groupBoxStyle(.glass)
        .onTapGesture {
            // To make the background not tappable for dismissal
        }
        .padding((selection != nil) || showingAllSteps ? 5 : 16)
        .onChange(of: currentStep) {
            if currentStep == nil {
                showingAllSteps = false
            }
        }
        .animation(.smooth, value: selection)
        .animation(.smooth.speed(1.5), value: showingAllSteps)
    }
    
    @ViewBuilder private func stepView(_ step: StudyProject.Step, binding: Binding<StudyProject.Step>) -> some View {
        // Show all steps only when necessary
        if showingAllSteps || currentStep == nil {
            StepRowView(step: binding, selection: $selection, deleteButton: deleteButton)
                .matchedGeometryEffect(id: step.id, in: namespace)
                .transition(.opacity.animation(.smooth(duration: 0.2)))
        } else {
            if let currentStep, step == currentStep {
                StepRowView(step: binding, selection: $selection, deleteButton: deleteButton)
                    .matchedGeometryEffect(id: step.id, in: namespace)
                    .transition(.opacity.animation(.smooth(duration: 0.2)))
            }
        }
    }
    
    private var heading: some View {
        Group {
            if showingAllSteps || currentStep == nil {
                Text("All Steps")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "stepHeading", in: namespace)
            } else {
                Text("Current Step")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "stepHeading", in: namespace)
            }
        }
        .transition(.blurReplace)
        .fontStyling(for: appearance)
    }
    
    private func expandButtonLabel() -> some View {
        Label(
            showingAllSteps ? "Show only current step" : "Show all steps",
            systemImage: showingAllSteps
            ? "arrow.down.right.and.arrow.up.left"
            : "arrow.up.backward.and.arrow.down.forward"
        )
        .labelStyle(.iconOnly)
        .font(.body)
        .bold()
    }
    
    private func deleteButton(for step: StudyProject.Step) -> some View {
        Button {
            delete(step)
        } label: {
            Label("Delete Step", systemImage: "trash.fill")
                .labelStyle(.iconOnly)
                .bold()
        }
        .buttonStyle(.pressable)
        .matchedGeometryEffect(id: "deleteButton", in: namespace)
    }
    
    private func expandAction() {
        Task { @MainActor in
            if showingAllSteps {
                selection = nil
                try? await Task.sleep(for: .seconds(0.2))
                showingAllSteps = false
            } else {
                showingAllSteps = true
                try? await Task.sleep(for: .seconds(0.2))
                selection = currentStep
            }
        }
    }
    
    private func delete(_ step: StudyProject.Step) {
        guard let index = steps.firstIndex(of: step) else { return }
        
        withAnimation {
            _ = steps.remove(at: index)
        }
    }
    
}

#Preview {
    @Previewable @State var project = StudyProject.example
    @Previewable @State var selection: StudyProject.Step?
    @Previewable @State var showingAllSteps = false
    
    ZStack {
        Rectangle()
            .fill(.linearGradient(colors: [.red, .indigo], startPoint: .bottom, endPoint: .topLeading))
            .ignoresSafeArea()
        
        ScrollView {
            StepsView(
                steps: $project.steps,
                selection: $selection,
                showingAllSteps: $showingAllSteps,
                appearance: project.appearance
            )
            
            Button("Deselect") {
                selection = nil
            }
        }
        .preferredColorScheme(.dark)
    }
}
