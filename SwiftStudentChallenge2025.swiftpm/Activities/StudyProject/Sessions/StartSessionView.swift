//
//  StartSessionView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 22/02/25.
//

import SwiftUI

// – [] Can't start pause before 30 mins of studying (calculate based on last pause).
// – [] Send notifications after 15 mins of pause.

struct StartSessionView: View {
    @Binding var isExpanded: Bool
    var project: StudyProject
    @Binding var showingEmotionLogger: Bool
    let onButtonPress: () -> Void
    
    @State private var duration: TimeInterval = 30*60
    @State private var allowPausing = false
    
    @State private var showingExpandButton: Bool
    @Namespace private var namespace
    
    @Environment(Model.self) private var model
    @Environment(\.modelContext) private var modelContext
    
    private var sessionCreated: Bool {
        project.currentSessionID != nil
    }
    
    init(isExpanded: Binding<Bool>, project: StudyProject, showingEmotionLogger: Binding<Bool>, onButtonPress: @escaping () -> Void) {
        _isExpanded = isExpanded
        self.project = project
        _showingEmotionLogger = showingEmotionLogger
        self.onButtonPress = onButtonPress
        
        _showingExpandButton = State(initialValue: project.currentSessionID == nil)
    }
    
    var body: some View {
        Group {
            if !isExpanded {
                if showingExpandButton {
                    ZStack(alignment: .bottom) {
                        ProgressiveBlur()
                            .ignoresSafeArea()
                            .frame(maxHeight: 70)
                        
                        expandButton
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            } else {
                sessionOptionsForm
            }
        }
        .onChange(of: project.currentSessionID) {
            if project.currentSessionID == nil {
                withAnimation {
                    showingExpandButton = true
                }
            }
        }
    }
    
    private var expandButton: some View {
        Button {
            withAnimation(.bouncy) {
                isExpanded.toggle()
            }
        } label: {
            Label(
                !sessionCreated ? "Start a Study Session" : "Study Well",
                systemImage: !sessionCreated ? "play.fill" : "checkmark"
            )
            .font(.headline)
            .padding(12)
            .frame(maxWidth: 350)

        }
        .buttonBorderShape(.roundedRectangle(radius: 24))
        .buttonStyle(.prominentGlass)
        .shadow(color: .black.opacity(0.2), radius: 10)
        .padding(.horizontal)
        .matchedGeometryEffect(id: "startButton", in: namespace)
        .onTapGesture(perform: onButtonPress)
        .padding(.bottom)
        .disabled(sessionCreated)
    }
    
    private var startButtonItem: some View {
        Button {
            Task { @MainActor in
                withAnimation {
                    isExpanded.toggle()
                }
                
                try? await Task.sleep(for: .seconds(0.3))
                
                withAnimation {
                    startSession()
                }
                
                try? await Task.sleep(for: .seconds(1.2))
                
                withAnimation {
                    showingExpandButton = false
                }
                
                resetState()
                
                try? await Task.sleep(for: .seconds(0.6))
                
                withAnimation {
                    showingEmotionLogger = true
                }
            }
        } label: {
            Label("Start", systemImage: "play.fill")
                .font(.headline)
                .fixedSize()
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(.prominentGlass)
        .matchedGeometryEffect(id: "startButton", in: namespace)
    }
    
    private var sessionOptionsForm: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(.glass)
                .ignoresSafeArea()
                .frame(maxHeight: 200)
            
            VStack {
                HStack(alignment: .center) {
                    Text("Study Session options")
                        .font(.title3)
                        .bold()
                        .fontStyling(for: project.appearance)
                    
                    Spacer()
                    
                    startButtonItem
                }
                .padding(.top, -15)
                
                Divider()
                    .padding(.bottom)
                
                VStack(spacing: 15) {
                    Stepper("**Duration:** \(duration.formatted(.duration))", value: $duration, in: (30*60)...(4*60*60), step: 15*60)
                    
                    Toggle("**Allow Pausing**", isOn: $allowPausing)
                        .disabled(duration < 60*60)
                }
                
            }
            .padding(.horizontal)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .onChange(of: duration) { oldValue, newValue in
            if oldValue == (45*60) && newValue != (30*60) {
                allowPausing = true
            }
            
            if newValue == (45*60)  {
                allowPausing = false
            }
        }
    }
    
    private func startSession() {
        model.startSession(
            for: project,
            duration: duration,
            allowPausing: allowPausing,
            in: modelContext
        )
    }
    
    private func resetState() {
        duration = 30*60
        allowPausing = false
    }
}
