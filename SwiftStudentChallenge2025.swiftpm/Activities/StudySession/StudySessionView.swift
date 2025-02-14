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
        VStack {
            if showingEmotionLogger {
                EmotionLogView()
            }
            
            Text(session.title)
        }
        .toolbar {
            Button("Debug", systemImage: "wrench.adjustable") {
                showingDebug.toggle()
            }
        }
        .sheet(isPresented: $showingDebug) {
            SessionDebugView(session: session)
                .presentationDetents([.medium])
        }
        .onAppear {
            currentSessionID = session.id.uuidString
            
            withAnimation {
                showingEmotionLogger = model.shouldShowEmotionLogger(for: session, context: modelContext)
            }
        }
    }
}
