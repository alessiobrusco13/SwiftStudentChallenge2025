//
//  MindfulnessView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 23/02/25.
//

import SwiftUI

struct MindfulnessView: View {
    let project: StudyProject
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 20) {
                Text("Reflect on your emotions to better understand the feelings that lead to procrastination.")
                    .font(.subheadline)
                
                DisclosureGroup {
                    VStack(alignment: .leading) {
                        if project.emotionLogs.isEmpty {
                            Text("Start a study session to log you're emotions.")
                                .font(.subheadline)
                        } else {
                            ForEach(project.emotionLogs) { log in
                                HStack {
                                    HStack(alignment: .firstTextBaseline, spacing: 5) {
                                        Text(String(describing: log.emotion).capitalized)
                                            .font(.headline)
                                        
                                        Text(log.date.formatted(date: .abbreviated, time: .shortened))
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(log.emotion.emoji)
                                        .fixedSize()
                                        .font(.title)
                                        .frame(maxWidth: 24, maxHeight: 24)
                                        .padding(10)
                                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                                }
                                .padding(.leading, 10)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                } label: {
                    Text("Emotion Logs")
                        .font(.headline)
                        .fontStyling(for: project.appearance)
                        .padding(.top, 15)
                }
                .disclosureGroupStyle(.borderedButton)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } label: {
            Text("Mindfulness")
                .fontStyling(for: project.appearance)
        }
        .groupBoxStyle(.glass)
        .padding(.horizontal, 16)
    }
}

#Preview {
    MindfulnessView(project: .example)
        .preferredColorScheme(.dark)
}
