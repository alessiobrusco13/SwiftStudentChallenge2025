//
//  PastSessionsView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 24/02/25.
//

import SwiftUI

struct PastSessionsView: View {
    let project: StudyProject
    
    var body: some View {
        GroupBox {
            Text("Past sessions")
                .frame(maxWidth: .infinity, alignment: .leading)
        } label: {
            Text("Past Study Sessions")
                .fontStyling(for: project.appearance)
        }
        .groupBoxStyle(.glass)
        .padding(.horizontal, 16)
    }
}
