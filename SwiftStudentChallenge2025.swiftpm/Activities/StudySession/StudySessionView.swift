//
//  StudySessionView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 13/02/25.
//

import SwiftUI

struct StudySessionView: View {
    @Bindable var session: StudySession
    
    @Environment(Model.self) private var model
    @Environment(\.modelContext) private var modelContext
    
    @AppStorage(Model.currentSessionIDKey) private var currentSessionID: String?
    
    @State private var editing = false
    @State private var showingEmotionLogger = false
    @State private var stepSelection: StudySession.Step?
    @State private var showingAllSteps = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(session.appearance.itemColorRepresentation.color.gradient.opacity(0.4))
                    .ignoresSafeArea()
                
                Rectangle()
                    .animation(.smooth(duration: 1)) { view in
                        view
                            .foregroundStyle(.black.opacity(
                                (stepSelection != nil) || showingAllSteps
                                ? 0.2
                                : 0
                            ))
                    }
                    .ignoresSafeArea()
                
                ScrollView {
                    StepsView(
                        steps: $session.steps,
                        selection: $stepSelection,
                        showingAllSteps: $showingAllSteps
                    )
                }
            }
            .topBar(behavior: .alwaysMinimized) { _ in
                StudySessionTopBar(session: session, editing: $editing)
            }
            .toolbarVisibility(.hidden)
            .presentationBackground {
                // Not the best implementation
                AnimatedBackgroundView()
            }
            .contentShape(.rect)
            .onTapGesture(perform: deselectSteps)
            .emotionLogger(isPresented: $showingEmotionLogger, session: session)
            .onAppear {
                currentSessionID = session.id.uuidString
                setupEmotionLogger()
            }
            .onDisappear {
                stepSelection = nil
                showingAllSteps = false
            }
            .sheet(isPresented: $editing) {
                SessionDebugView(session: session)
            }
        }
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
                showingEmotionLogger = model.shouldShowEmotionLogger(for: session, context: modelContext)
            }
        }
    }
}
