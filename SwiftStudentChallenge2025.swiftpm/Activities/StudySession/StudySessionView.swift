//
//  StudySessionView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 13/02/25.
//

import SwiftUI

struct StudySessionView: View {
    @Bindable var session: StudySession
    @State private var showingDebug = false
    
    var body: some View {
        Text(session.title)
            .toolbar {
                Button("Debug", systemImage: "wrench.adjustable") {
                    showingDebug.toggle()
                }
            }
            .sheet(isPresented: $showingDebug) {
                SessionDebugView(session: session)
            }
    }
}
