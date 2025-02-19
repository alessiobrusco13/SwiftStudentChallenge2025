//
//  StepsView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 19/02/25.
//

import SwiftUI

struct StepsView: View {
    @Binding var steps: [StudySession.Step]
    @State private var selection: StudySession.Step?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(selection == nil ? 0 : 0.2))
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack {
                        ForEach($steps) { $step in
                            StepRowView(step: $step, selection: $selection)
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
            }
            
        }
        
        .contentShape(.rect)
        .onTapGesture {
            selection = nil
        }
        .animation(.default.speed(2), value: selection?.id)
    }
}

#Preview {
    @Previewable @State var session = StudySession.example
    
    StepsView(steps: $session.steps)
        .preferredColorScheme(.dark)
}
