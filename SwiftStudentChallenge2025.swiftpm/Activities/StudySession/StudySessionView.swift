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
    
    @State private var showingDebug = false
    @State private var showingEmotionLogger = false
    
    var body: some View {
        ZStack {
            Group {
                Rectangle()
                    .fill(session.appearance.itemColorRepresentation.color.gradient.opacity(0.5))
             
                ProgressiveBlur()
            }
            .ignoresSafeArea()
        }
        .toolbar {
            Button("Debug", systemImage: "wrench.adjustable") {
                showingDebug.toggle()
            }
        }
        .emotionLogger(isPresented: $showingEmotionLogger, session: session)
        .sheet(isPresented: $showingDebug) {
            SessionDebugView(session: session)
                .presentationDetents([.medium])
        }
        .onAppear {
            currentSessionID = session.id.uuidString
            
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(0.3))
                
                withAnimation {
                    showingEmotionLogger = model.shouldShowEmotionLogger(for: session, context: modelContext)
                }
            }
        }
    }
}
