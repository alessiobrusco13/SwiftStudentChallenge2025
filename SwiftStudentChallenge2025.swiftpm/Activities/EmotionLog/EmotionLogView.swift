//
//  EmotionLogView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 14/02/25.
//

import SwiftUI

struct EmotionLogView: View {
    let session: StudySession
    let dismiss: () -> Void
    
    @Environment(Model.self) private var model
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("How are you feeling right now?")
                    .lineLimit(2, reservesSpace: true)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text("Select one of the emotions below to track your overall mood while studying.")
                    .lineLimit(3, reservesSpace: true)
            }
            .multilineTextAlignment(.center)
            .padding([.top, .horizontal])
            
            Divider()
                .padding(.horizontal, -23)
            
            HStack {
                ForEach(Emotion.allCases, id: \.self) { emotion in
                    Button {
                        withAnimation {
                            model.log(emotion, for: session, in: modelContext)
                            dismiss()
                        }
                    } label: {
                        Text(emotion.emoji)
                            .font(.largeTitle)
                            .frame(width: 37, height: 37)
                    }
                    .buttonStyle(.glassProminent)
                    .buttonBorderShape(.capsule)
                }
            }
            .padding([.bottom, .horizontal])
        }
        .background(.glass(shadowRadius: 10), in: .rect(cornerRadius: 32))
        .colorScheme(.dark)
        .compositingGroup()
        .frame(maxWidth: 270)
        .padding()
    }
}

#Preview {
    EmotionLogView(session: .example) {
        
    }
    .environment(Model.preview)
}
