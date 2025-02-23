//
//  EmotionLoggerModifier.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 15/02/25.
//

import SwiftUI

struct EmotionLoggerModifier: ViewModifier {
    @Binding var isPresented: Bool
    let project: StudyProject
    
    func body(content: Content) -> some View {
        content
            .animation(.smooth, value: isPresented)
            .overlay {
                if isPresented {
                    EmotionLogView(project: project) {
                        isPresented = false
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(
                        .move(edge: .bottom)
                        .combined(with: .opacity)
                    )
                    .background {
                        ProgressiveBlur()
                            .ignoresSafeArea()
                            .transition(.opacity)
                    }
                }
            }
    }
}

extension View {
    func emotionLogger(isPresented: Binding<Bool>, project: StudyProject) -> some View {
        modifier(EmotionLoggerModifier(isPresented: isPresented, project: project))
    }
}
