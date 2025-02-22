//
//  DebugView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 22/02/25.
//

import SwiftData
import SwiftUI

struct DebugView: View {
    @Query private var projects: [StudyProject]
    @AppStorage(Model.activeProjectIDKey) private var activeProjectID: String?
    
    var activeProject: StudyProject? {
        guard let activeProjectID else { return nil }
        return projects.first { $0.id.uuidString == activeProjectID }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Active Project") {
                    if let activeProject {
                        Text("**ID:** \(activeProject.id.uuidString)")
                        Text("**Title:** \(activeProject.title)")
                    } else {
                        Text("There's no active project at the moment")
                    }
                }
            }
            .navigationTitle("Debug")
        }
    }
}

struct DebugViewModifier: ViewModifier {
    @State private var showingDebugView = false
    @Environment(\.modelContext) private var modelContext
    
    func body(content: Content) -> some View {
        content
            .onTapGesture(count: 3) {
                showingDebugView.toggle()
            }
            .sheet(isPresented: $showingDebugView) {
                DebugView()
                    .environment(\.modelContext, modelContext)
            }
    }
}

extension View {
    func allowDebug() -> some View {
        modifier(DebugViewModifier())
    }
}
