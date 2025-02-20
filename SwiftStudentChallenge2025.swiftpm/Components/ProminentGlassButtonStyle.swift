//
//  ProminentGlassButtonStyle.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

struct ProminentGlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(.prominentGlass, in: .buttonBorder)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .colorScheme(.light)
    }
}

extension ButtonStyle where Self == ProminentGlassButtonStyle {
    static var prominentGlass: Self { .init() }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.red, .blue, .mint, .yellow, .indigo], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
        HStack {
            Button {
                
            } label: {
                Label("Press Me", systemImage: "star")
            }
            .buttonBorderShape(.capsule)
            
            Button {
                
            } label: {
                Image(systemName: "gear")
                    .font(.title3)
                
            }
            .buttonBorderShape(.circle)
        }
        .buttonStyle(.prominentGlass)
    }
}
