//
//  StudyProjectView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 13/02/25.
//

import SwiftUI

struct StudyProjectView: View {
    @Bindable var project: StudyProject
    
    @Environment(Model.self) private var model
    @Environment(\.modelContext) private var modelContext
    
    @State private var isEditing = false
    @State private var showingEmotionLogger = false
    
    @State private var stepSelection: StudyProject.Step?
    @State private var showingAllSteps = false
    
    @State private var startSessionViewExpanded = false
    
    @State private var showingCompletedAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(project.appearance.itemColorRepresentation.color.gradient.opacity(0.4))
                    .ignoresSafeArea()
                
                allStepsSelectionBackground
                
                ScrollView {
                    VStack(spacing: 12) {
                        if let session = project.currentSession() {
                            StudySessionView(project: project, session: session)
                                .allowsHitTesting(stepSelection == nil && !showingEmotionLogger)
                        }
                        
                        StepsView(
                            project: project,
                            selection: $stepSelection,
                            showingAllSteps: $showingAllSteps
                        )
                        
                        MindfulnessView(project: project)
                            .allowsHitTesting(stepSelection == nil)
                            .animation(.default, value: showingAllSteps || stepSelection != nil)
                        
//                        PastSessionsView(project: project)
//                            .allowsHitTesting(stepSelection == nil)
//                            .animation(.default, value: showingAllSteps || stepSelection != nil)
                    }
                }
            }
            .topBar(behavior: .alwaysMinimized) { _ in
                StudyProjectTopBar(project: project, isEditing: $isEditing)
            }
            .toolbarVisibility(.hidden)
            .overlay {
                Rectangle()
                    .fill(.black.opacity(startSessionViewExpanded ? 0.4 : 0))
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            startSessionViewExpanded = false
                        }
                    }
            }
            .safeAreaInset(edge: .bottom) {
                // This maybe adds opacity to the background. It dims everything but the timer. On tap everything gets back to normal for little time
                StartSessionView(
                    isExpanded: $startSessionViewExpanded,
                    project: project,
                    showingEmotionLogger: $showingEmotionLogger
                ) {
                    stepSelection = nil
                }
                .disabled(stepSelection != nil || showingAllSteps)
            }
            .presentationBackground(content: AnimatedBackgroundView.init)
            .contentShape(.rect)
            .onTapGesture(perform: deselectSteps)
            .glassAlert(
                "Hold on, how are you feeling right now?",
                isPresented: $showingEmotionLogger,
                message: "Select one of the emotions below and try to understand why you're feeling this way.",
                dismissiveBackground: false
            ) {
                EmotionLogView(project: project)
            }
            .glassAlert(
                "Well Done!",
                isPresented: $showingCompletedAlert,
                message: "You've completed this project, congrats!"
            ) {
                Button("Nice") {
                    showingCompletedAlert = false
                }
                .font(.headline)
                .buttonStyle(.pressable)
            }
            .onDisappear {
                stepSelection = nil
                showingAllSteps = false
            }
            .sheet(isPresented: $isEditing) {
                ProjectDebugView(project: project)
            }
            .interactiveDismissDisabled(startSessionViewExpanded)
        }
        .onChange(of: project.isCompleted) {
            showingCompletedAlert = project.isCompleted
            
            if project.isCompleted {
                if let currentSessionID = project.currentSessionID, let session = project.sessions.first(where: { $0.id == currentSessionID }) {
                    session.cancel()
                }
            }
        }
    }
    
    var allStepsSelectionBackground: some View {
        // Dims the screen when a step is selected.
        Rectangle()
            .animation(.smooth(duration: 1)) { view in
                view
                    .foregroundStyle(.black.opacity(
                        (stepSelection != nil) || showingAllSteps
                        ? 0.4
                        : 0
                    ))
            }
            .ignoresSafeArea()
    }
    
    func deselectSteps() {
        guard (stepSelection != nil) || showingAllSteps else {
            return
        }
        
        showingAllSteps = false
        stepSelection = nil
    }
}
