//
//  StepsView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 19/02/25.
//

import SwiftUI

struct StepsView: View {
    @Binding var steps: [StudySession.Step]
    @Binding var selection: StudySession.Step?
    @Binding var showingAllSteps: Bool
    
    @Namespace private var namespace
    
    var currentStep: StudySession.Step? {
        steps.first { $0.completed == false }
    }
    
    var body: some View {
        GroupBox {
            VStack(spacing: 20) {
                ForEach($steps) { $step in
                    if showingAllSteps || currentStep == nil {
                        StepRowView(step: $step, selection: $selection)
                            .matchedGeometryEffect(id: step.id, in: namespace)
                    } else {
                        if let currentStep, step == currentStep {
                            StepRowView(step: $step, selection: $selection)
                                .matchedGeometryEffect(id: step.id, in: namespace)
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text(showingAllSteps ? "All Steps" : "Current Step")
                
                Spacer()
                
                Button(action: expansionAction, label: expansionButtonLabel)
                    .buttonBorderShape(.circle)
                    .buttonStyle(.prominentGlass)
                    .colorScheme(.light)
            }
        }
        .groupBoxStyle(.glass)
        .padding((selection != nil) || showingAllSteps ? 5 : 16)
        .animation(.smooth, value: selection)
        .animation(.smooth.speed(1.5), value: showingAllSteps)
    }
    
    func expansionButtonLabel() -> some View {
        Label(
            showingAllSteps ? "Show only current step" : "Show all steps",
            systemImage: showingAllSteps || selection != nil 
                ? "arrow.down.right.and.arrow.up.left"
                : "arrow.up.backward.and.arrow.down.forward"
        )
        .labelStyle(.iconOnly)
        .font(.body)
        .bold()
    }
    
    func expansionAction() {
        switch (showingAllSteps, selection != nil) {
        case (false, true):
            selection = nil
            
        case (false, false):
            Task { @MainActor in
                showingAllSteps = true
                try? await Task.sleep(for: .seconds(0.2))
                selection = currentStep
            }
            
        default:
            Task { @MainActor in
                selection = nil
                try? await Task.sleep(for: .seconds(0.2))
                showingAllSteps = false
            }
        }
    }
}

#Preview {
    @Previewable @State var session = StudySession.example
    @Previewable @State var selection: StudySession.Step?
    @Previewable @State var showingAllSteps = false
    
    ZStack {
        Rectangle()
            .fill(.linearGradient(colors: [.red, .indigo], startPoint: .bottom, endPoint: .topLeading))
            .ignoresSafeArea()
        
        VStack {
            StepsView(
                steps: $session.steps,
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
