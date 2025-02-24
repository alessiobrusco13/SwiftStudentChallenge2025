//
//  StepsView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 19/02/25.
//

import SwiftUI

// Add a button to add steps. It adds an empty one, then it selects it and focuses it.
struct StepsView: View {
    @Bindable var project: StudyProject
    @Binding var selection: StudyProject.Step?
    @Binding var showingAllSteps: Bool
    
    @Namespace private var namespace
    @FocusState private var nameFieldSelection: UUID?
    
    private var currentStep: StudyProject.Step? {
        project.steps.first { $0.isCompleted == false }
    }
    
    private var paddingEdges: Edge.Set.ArrayLiteralElement {
        if project.currentSessionID == nil || ((selection != nil) && !showingAllSteps) {
            [.horizontal, .top]
        } else {
            [.horizontal]
        }
    }
    
    var body: some View {
        GroupBox {
            VStack(spacing: 20) {
                ForEach($project.steps) { $step in
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
                
                newStepButton
                expandButton
            }
        }
        .groupBoxStyle(.glass)
        .onTapGesture {
            // To make the background not tappable for dismissal
        }
        .padding(
            paddingEdges,
            (selection != nil) || showingAllSteps ? 5 : 16
        )
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
            StepRowView(
                step: binding,
                selection: $selection,
                nameFieldSelection: $nameFieldSelection,
                deleteButton: deleteButton
            )
                .matchedGeometryEffect(id: step.id, in: namespace)
                .transition(.opacity.animation(.smooth(duration: 0.2)))
        } else {
            if let currentStep, step == currentStep {
                StepRowView(
                    step: binding,
                    selection: $selection,
                    nameFieldSelection: $nameFieldSelection,
                    deleteButton: deleteButton
                )
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
        .fontStyling(for: project.appearance)
    }
    
    private var expandButton: some View {
        Button(action: expandAction) {
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
        .buttonBorderShape(.circle)
        .buttonStyle(.prominentGlass)
    }
    
    private var newStepButton: some View {
        Button(action: addNewStep) {
            Label(
                "Add new step",
                systemImage: "plus"
            )
            .labelStyle(.iconOnly)
            .font(.body)
            .bold()
        }
        .buttonBorderShape(.circle)
        .buttonStyle(.prominentGlass)
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
    
    private func addNewStep() {
        let newStep = StudyProject.Step(name: "New Step")
        
        Task { @MainActor in
            showingAllSteps = true
            try? await Task.sleep(for: .seconds(0.3))
            
            withAnimation {
                project.steps.append(newStep)
            }
                        
            selection = newStep
            
            #warning("KNOWN ISSUE: Doesn't focus the text field.")
            nameFieldSelection = newStep.id
        }
    }
    
    private func expandAction() {
        Task { @MainActor in
            if showingAllSteps {
                selection = nil
                try? await Task.sleep(for: .seconds(0.1))
                showingAllSteps = false
            } else {
                showingAllSteps = true
//                try? await Task.sleep(for: .seconds(0))
                selection = currentStep
            }
        }
    }
    
    private func delete(_ step: StudyProject.Step) {
        guard let index = project.steps.firstIndex(of: step) else { return }
        
        withAnimation {
            _ = project.steps.remove(at: index)
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
                project: project,
                selection: $selection,
                showingAllSteps: $showingAllSteps
            )
            
            Button("Deselect") {
                selection = nil
            }
        }
        .preferredColorScheme(.dark)
    }
}
