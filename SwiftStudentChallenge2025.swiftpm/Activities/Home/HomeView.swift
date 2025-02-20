//
//  HomeView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 09/02/25.
//

import SwiftData
import SwiftUI

// – [] Scroll lag when showing welcome message.
// – [] Show 'current' session.

struct HomeView: View {
    @State private var topBarMinimized = false
    @State private var selection: StudySession?
    @Namespace private var namespace
    
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
            ZStack {
                AnimatedBackgroundView()
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        //                        if let currentSession {
                        //                            StudySessionItemView(session: currentSession)
                        //                        }
                        
                        ForEach(activeSessions + completedSessions) { session in
                            Button {
                                selection = session
                            } label: {
                                StudySessionItemView(session: session, namespace: namespace)
                                    .shadow(color: .black.opacity(0.1), radius: 10)
                            }
                            .buttonStyle(.pressable)
                            .padding(.horizontal)
                        }
                    }
                }
                .toolbarVisibility(.hidden, for: .navigationBar)
                .frame(maxWidth: .infinity)
                .topBar { minimized in
                    HomeTopBar(minimized: minimized) {
                        Button {
                        } label: {
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                                .font(.title3)
                        }
                        .buttonBorderShape(.circle)
                        .buttonStyle(.prominentGlass)
                        
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
            }
        }
        .animation(.default, value: otherActiveSessions + completedSessions)
        .fullScreenCover(item: $selection) { session in
            StudySessionView(session: session)
                .navigationTransition(.zoom(sourceID: session.id, in: namespace))
        }
    }
}

#Preview {
    Previewer(model: .preview) {
        HomeView()
            .environment(Model.preview)
        
    }
}
