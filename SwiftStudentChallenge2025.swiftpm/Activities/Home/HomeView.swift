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
                    ForEach(otherActiveSessions) { session in
                            StudySessionItemView(session: session)
                    }
                }
                
                Section("Completed") {
                    ForEach(completedSessions) { session in
                            StudySessionItemView(session: session)
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
                Text(session.title)
                    .onAppear {
                        guard session.completed == false else { return }
                        currentSessionID = session.id.uuidString
                    }
            }
        }
    }
    
    var topBar: some View {
        TopBar(minimized: $topBarMinimized) {
            // Add buttons
        }
    }
}

#Preview {
    Previewer(model: .preview) {
        HomeView()
            .environment(Model.preview)
    }
}
