//
//  GlassProminentButtonStyle.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

struct GlassProminentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(
                .thinMaterial
                    .shadow(
                        .inner(
                            color: .white.opacity(0.6),
                            radius: 1
                        )
                    )
                    .shadow(
                        .drop(
                            color: .white.opacity(0.6),
                            radius: 1
                        )
                    )
                ,
                in: .buttonBorder
            )
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .colorScheme(.light)
    }
}

extension ButtonStyle where Self == GlassProminentButtonStyle {
    static var glassProminent: Self { .init() }
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
        .buttonStyle(.glassProminent)
    }
}
