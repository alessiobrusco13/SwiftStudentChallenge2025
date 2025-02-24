//
//  EmotionLogView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 14/02/25.
//

import SwiftUI

struct EmotionLogView: View {
    let project: StudyProject
    let dismiss: () -> Void
    
    @Environment(Model.self) private var model
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        HStack {
            ForEach(Emotion.allCases, id: \.self) { emotion in
                Button {
                    withAnimation {
                        model.log(emotion, for: project, in: modelContext)
                        dismiss()
                    }
                } label: {
                    Text(emotion.emoji)
                        .font(.largeTitle)
                        .frame(width: 37, height: 37)
                }
                .buttonStyle(.prominentGlass)
                .buttonBorderShape(.capsule)
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview {
    EmotionLogView(project: .example) { }
    .environment(Model.preview)
}
