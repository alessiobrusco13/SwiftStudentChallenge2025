//
//  HomeView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 09/02/25.
//

import SwiftData
import SwiftUI

// [] Scroll lag when showing welcome message.

struct HomeView: View {
    @State private var topBarMinimized = false
    
    @Query(filter: HomeView.activeSessionsFilter, sort: \.endDate) private var activeSessions: [StudySession]
    @Query(filter: HomeView.completedSessionsFilter, sort: \.startDate) private var completedSessions: [StudySession]
    
    static let activeSessionsFilter = #Predicate<StudySession> { $0.completed == false }
    static let completedSessionsFilter = #Predicate<StudySession> { $0.completed }
    
    @AppStorage(Model.currentSessionIDKey) private var currentSessionID: String?
    
    @Environment(\.modelContext) private var modelContext
    
    var currentSession: StudySession? {
        guard
            let currentSessionID,
            let uuid = UUID(uuidString: currentSessionID),
            let session = activeSessions.first(where: { $0.id == uuid })
        else {
            return nil
        }
        
        return session
    }
    
    var otherActiveSessions: [StudySession] {
        guard let currentSession else {
            return activeSessions
        }
        
        return activeSessions.filter { $0.id != currentSession.id }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .overlay {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                    }
                    .blur(radius: 10)
                
                ScrollView(showsIndicators: false) {
                    Section("Current") {
                        if let currentSession {
                            StudySessionItemView(session: currentSession)
                        } else {
                            Text("There's no current session.")
                        }
                    }
                    
                    Divider()
                    
                    Section("Active") {
                        VStack(spacing: 20) {
                            ForEach(otherActiveSessions) { session in
                                StudySessionItemView(session: session)
                            }
                        }
                    }
                    
                    Section("Completed") {
                        VStack(spacing: 20) {
                            ForEach(completedSessions) { session in
                                StudySessionItemView(session: session)
                            }
                        }
                    }
                }
                .toolbarVisibility(.hidden, for: .navigationBar)
                .frame(maxWidth: .infinity)
                .safeAreaInset(edge: .top) {
                    topBar
                }
                .toggleOnScroll($topBarMinimized)
                .navigationDestination(for: StudySession.self) { session in
                    StudySessionView(session: session)
                }
            }
        }
        .animation(.default, value: otherActiveSessions)
        .animation(.default, value: completedSessions)
    }
    
    var topBar: some View {
        TopBar(minimized: $topBarMinimized) {
            // Add buttons
            
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .font(.title3)
            }
            .buttonBorderShape(.circle)
            .buttonStyle(.glassProminent)
            
            Button {
                
            } label: {
                Image(systemName: "gear")
                    .fontWeight(.bold)
                    .font(.title3)
            }
            .buttonBorderShape(.circle)
            .buttonStyle(.glass)
        }
    }
    
    func binding(for session: StudySession) -> Binding<StudySession> {
        Binding {
            session
        } set: {
            modelContext.insert($0)
        }
    }
}

#Preview {
    Previewer(model: .preview) {
        HomeView()
            .environment(Model.preview)
            
    }
}
