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
                    .fill(session.appearance.itemColorRepresentation.color.gradient.opacity(0.4))
                    .ignoresSafeArea()
                
                ScrollView {
                    ForEach(0..<100, id: \.self) {
                        Text("\($0)")
                            .padding(30)
                            .background(.glass, in: .circle)
                    }
                }
            }
            .topBar(title: session.title, behavior: .alwaysMinimized) { title in
                title
                    .fontStyling(for: session)
                    .overlay(alignment: .leading) {
                        Button(action: dismiss.callAsFunction) {
                            Label("Home", systemImage: "xmark")
                                .font(.title3)
                                .fontWeight(.bold)
                                .labelStyle(.iconOnly)
                                .padding(1)
                        }
                        .buttonStyle(.glass)
                        .buttonBorderShape(.circle)
                    }
            }
            .toolbarVisibility(.hidden)
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
