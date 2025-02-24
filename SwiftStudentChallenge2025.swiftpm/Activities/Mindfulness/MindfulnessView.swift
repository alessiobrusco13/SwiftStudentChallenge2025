//
//  MindfulnessView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 23/02/25.
//

import SwiftUI

struct MindfulnessView: View {
    let project: StudyProject
    @State private var emotionLogsExpanded = false
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 10) {
                
                if project.emotionLogs.isEmpty {
                    Text("You haven’t started a study session yet. Once you do, your logged emotions will appear here.")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                        .padding(.top, -15)
                } else {
                    Text("Take a moment to revisit what you felt while studying, your emotions matter.")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                        .padding(.top, -15)
                    
                    VStack {
                        ForEach(project.emotionLogs) { log in
                            HStack {
                                HStack(alignment: .firstTextBaseline, spacing: 5) {
                                    Text(String(describing: log.emotion).capitalized)
                                        .font(.headline)
                                    
                                    Text(log.date.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Text(log.emotion.emoji)
                                    .fixedSize()
                                    .font(.title)
                                    .frame(maxWidth: 24, maxHeight: 24)
                                    .padding(10)
                                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } label: {
            Text("Mindfulness")
                .fontStyling(for: project.appearance)
        }
        .groupBoxStyle(.glass)
        .padding(.horizontal, 16)
        .onChange(of: project.emotionLogs.isEmpty) {
            if project.emotionLogs.count == 1 {
                withAnimation {
                    emotionLogsExpanded = true
                }
            }
            
        }
    }
}

#Preview {
    MindfulnessView(project: .example)
        .preferredColorScheme(.dark)
}
