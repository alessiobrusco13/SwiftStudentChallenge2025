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
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage(Model.currentSessionIDKey) private var currentSessionID: String?
    
    @State private var showingDebug = false
    @State private var showingEmotionLogger = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(session.appearance.itemColorRepresentation.color.gradient.opacity(0.5))
                        .ignoresSafeArea()
            }
            .navigationTitle(session.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Home", systemImage: "chevron.down") {
                    dismiss()
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.glass)
            }
        }
        .presentationBackground {
            // Not the best implementation
            AnimatedBackgroundView()
        }
//        .emotionLogger(isPresented: $showingEmotionLogger, session: session)
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
