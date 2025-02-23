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
    
    @AppStorage(Model.activeProjectIDKey) private var currentProjectID: String?
    
    @State private var isEditing = false
    @State private var showingEmotionLogger = false
    
    @State private var stepSelection: StudyProject.Step?
    @State private var showingAllSteps = false
    
    @State private var startSessionViewExpanded = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(project.appearance.itemColorRepresentation.color.gradient.opacity(0.4))
                    .ignoresSafeArea()
                
                allStepSelectionBackground
                
                ScrollView {
                    VStack(spacing: 12) {
                        if let session = project.currentSession() {
                            StudySessionView(project: project, session: session)
                                .allowsHitTesting(stepSelection == nil)
                        }
                        
                        StepsView(
                            project: project,
                            selection: $stepSelection,
                            showingAllSteps: $showingAllSteps
                        )
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
                StartSessionView(isExpanded: $startSessionViewExpanded, project: project) {
                    stepSelection = nil
                }
                .disabled(stepSelection != nil || showingAllSteps)
            }
            .presentationBackground {
                // Not the best implementation
                AnimatedBackgroundView()
            }
            .contentShape(.rect)
            .onTapGesture(perform: deselectSteps)
            //            .emotionLogger(isPresented: $showingEmotionLogger, project: project)
            .onAppear {
                currentProjectID = project.id.uuidString
                setupEmotionLogger()
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
    }
    
    var allStepSelectionBackground: some View {
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
    
    func setupEmotionLogger() {
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(0.6))
            
            withAnimation(.smooth) {
                showingEmotionLogger = model.shouldShowEmotionLogger(for: project, context: modelContext)
            }
        }
    }
}
