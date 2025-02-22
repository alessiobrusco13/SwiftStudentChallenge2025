//
//  StartProjectView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 22/02/25.
//

import SwiftUI

// – [] Can't start pause before 30 mins of studying (calculate based on last pause).
// – [] Send notifications after 15 mins of pause.


struct StartProjectView: View {
    @Binding var isExpanded: Bool
    let appearance: StudyProject.Appearance
    let onButtonPress: () -> Void
    
    @State private var duration = 0.5
    @State private var allowPausing = false
    
    @Namespace private var namespace
    
    var durationString: String {
        let hours = floor(duration)
        let minutes = (duration - hours) * 60
        
        let hoursString = hours != 0 ? "\(hours.formatted()) hr " : ""
        let minutesString = minutes != 0 ? "\(minutes.formatted()) min" : ""
        
        return hoursString + minutesString
    }
    
    var body: some View {
        if !isExpanded {
            ZStack(alignment: .bottom) {
                ProgressiveBlur()
                    .ignoresSafeArea()
                    .frame(maxHeight: 70)
                
                startButton
            }
        } else {
            sessionOptionsForm
        }
    }
    
    private var startButton: some View {
        Button {
            withAnimation(.bouncy) {
                isExpanded.toggle()
            }
        } label: {
            Label("Start a Study Session", systemImage: "play.fill")
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
    }
    
    private var sessionOptionsForm: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(.glass)
                .ignoresSafeArea()
                .frame(maxHeight: 200)
            
            VStack(spacing: 15) {
                VStack {
                    HStack {
                        Text("Study Session options")
                            .font(.title3)
                            .bold()
                            .fontStyling(for: appearance)
                        
                        Spacer()
                        
                        startButtonItem
                    }
                    
                    Divider()
                }
                
                Stepper("**Duration:** \(durationString)", value: $duration, in: 0.5...4, step: 0.5)
                
                Toggle("**Allow Pausing**", isOn: $allowPausing)
                    .disabled(duration < 1)
                
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
    
    private var startButtonItem: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            Label("Start", systemImage: "play.fill")
                .font(.headline)
                .fixedSize()
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(.prominentGlass)
        .matchedGeometryEffect(id: "startButton", in: namespace)
        .padding(.bottom)
    }
    
}
