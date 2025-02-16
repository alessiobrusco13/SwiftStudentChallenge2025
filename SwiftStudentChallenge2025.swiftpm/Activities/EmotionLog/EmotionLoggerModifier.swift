//
//  EmotionLoggerModifier.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 15/02/25.
//

import SwiftUI

struct EmotionLoggerModifier: ViewModifier {
    @Binding var isPresented: Bool
    let session: StudySession
    
    func body(content: Content) -> some View {
        content
            .animation(.snappy, value: isPresented)
            .overlay {
                if isPresented {
                    EmotionLogView(session: session) {
                        isPresented = false
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        ProgressiveBlur()
                            .ignoresSafeArea()
                            .transition(.opacity)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
    }
}

extension View {
    func emotionLogger(isPresented: Binding<Bool>, session: StudySession) -> some View {
        modifier(EmotionLoggerModifier(isPresented: isPresented, session: session))
    }
}
