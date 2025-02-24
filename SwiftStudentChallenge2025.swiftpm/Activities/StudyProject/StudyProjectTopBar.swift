//
//  StudyProjectTopBar.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 19/02/25.
//

import SwiftUI

struct StudyProjectTopBar: View {
    let project: StudyProject
    @Binding var isEditing: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Group {
            HStack(spacing: 5) {
                Image(systemName: project.symbol.rawValue)
                Text(project.title)
            }
            .font(.headline)
            .fontStyling(for: project.appearance)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .frame(maxWidth: 250)
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .leading) {
            HStack {
                Button(action: dismiss.callAsFunction) {
                    Label("Home", systemImage: "xmark")
                        .font(.title3)
                        .fontWeight(.bold)
                        .labelStyle(.iconOnly)
                        .padding(1)
                }
                
                Spacer()
                
                Button {
                    isEditing = true
                } label: {
                    Label("Edit Project", systemImage: "slider.horizontal.3")
                        .font(.title3)
                        .fontWeight(.bold)
                        .labelStyle(.iconOnly)
                        .padding(1)
                }
            }
            .buttonStyle(.glass)
            .buttonBorderShape(.circle)
        }
        
    }
}
