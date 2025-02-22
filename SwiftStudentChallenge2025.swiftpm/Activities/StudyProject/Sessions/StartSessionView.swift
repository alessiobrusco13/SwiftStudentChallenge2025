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
    let onButtonPress: () -> Void
    
    @State private var duration = 0.5
    @State private var allowPausing = false
    
    @State private var showingExpandButton: Bool
    @Namespace private var namespace
    
    @Environment(Model.self) private var model
    @Environment(\.modelContext) private var modelContext
    
    var durationString: String {
        let hours = floor(duration)
        let minutes = (duration - hours) * 60
        
        let hoursString = hours != 0 ? "\(hours.formatted()) hr " : ""
        let minutesString = minutes != 0 ? "\(minutes.formatted()) min" : ""
        
        return hoursString + minutesString
    }
    
    var sessionCreated: Bool {
        project.currentSessionID != nil
    }
    
    init(isExpanded: Binding<Bool>, project: StudyProject, onButtonPress: @escaping () -> Void) {
        _isExpanded = isExpanded
        self.project = project
        self.onButtonPress = onButtonPress
        
        _showingExpandButton = State(initialValue: project.currentSessionID == nil)
    }
    
    var body: some View {
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
                    startSession()
                    isExpanded.toggle()
                }
                
                try? await Task.sleep(for: .seconds(1.5))
                
                withAnimation {
                    showingExpandButton = false
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
                    Stepper("**Duration:** \(durationString)", value: $duration, in: 0.5...4, step: 0.5)
                    
                    Toggle("**Allow Pausing**", isOn: $allowPausing)
                        .disabled(duration < 1)
                }
                
            }
            .padding(.horizontal)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .onChange(of: duration) { oldValue, newValue in
            if oldValue == 0.5 {
                allowPausing = true
            }
            
            if newValue == 0.5  {
                allowPausing = false
            }
        }
    }
    
    func startSession() {
        model.startSession(
            for: project,
            duration: duration,
            allowPausing: allowPausing,
            in: modelContext
        )
    }
}
