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
    @State private var showingStartSessionPicker = false
    
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(session.appearance.itemColorRepresentation.color.gradient.opacity(0.4))
                    .ignoresSafeArea()
                
                
                // Dims the screen when a step is selected.
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
                        showingAllSteps: $showingAllSteps,
                        appearance: session.appearance
                    )
                }
            }
            .topBar(behavior: .alwaysMinimized) { _ in
                StudySessionTopBar(session: session, editing: $editing)
            }
            .toolbarVisibility(.hidden)
            .safeAreaInset(edge: .bottom) {
                ZStack(alignment: .bottom) {
                    ProgressiveBlur()
                        .ignoresSafeArea()
                        .frame(maxHeight: 70)
                    
                    if showingStartSessionPicker {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.prominentGlass)
                            .colorScheme(.light)
                            .frame(maxHeight: 300)
                            .ignoresSafeArea()
                            .shadow(color: .black.opacity(0.2), radius: 10)
                            .padding(.horizontal)
                            .matchedGeometryEffect(id: "test", in: namespace)
                            .onTapGesture {
                                withAnimation(.bouncy(duration: 0.2)) {
                                    showingStartSessionPicker.toggle()
                                }
                            }
                    } else {
                        Button {
                            // This maybe adds opacity to the background. It dims everything but the timer. On tap everything gets back to normal for little time
                            withAnimation(.bouncy(duration: 0.2)) {
                                showingStartSessionPicker.toggle()
                            }
                        } label: {
                            Text("Start Study Session")
                                .font(.headline)
                                .padding(12)
                                .frame(maxWidth: 350)
                        }
                        .buttonBorderShape(.roundedRectangle(radius: 24))
                        .buttonStyle(.prominentGlass)
                        .shadow(color: .black.opacity(0.2), radius: 10)
                        .padding(.horizontal)
                        .matchedGeometryEffect(id: "test", in: namespace)
                    }
                }
            }
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
            //            .sheet(isPresented: $showingStartSessionPicker) {
            //                Text("Hello")
            //                    .presentationDetents([.fraction(0.4)])
            //                    .presentationBackground(.glass)
            //                    .presentationCornerRadius(32)
            //                    .preferredColorScheme(.light)
            //            }
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
