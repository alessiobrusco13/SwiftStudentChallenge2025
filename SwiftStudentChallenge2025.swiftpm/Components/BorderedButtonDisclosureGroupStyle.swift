//
//  BorderedButtonDisclosureGroupStyle.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 23/02/25.
//

import SwiftUI

struct BorderedButtonDisclosureGroupStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.label
                
                Spacer()
                
                Button {
                    withAnimation {
                        configuration.isExpanded.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(configuration.isExpanded ? 90 : 0))
                        .labelStyle(.iconOnly)
                        .bold()
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.prominentGlass)
            }
            .onTapGesture {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            }
            
            if configuration.isExpanded {
                configuration.content
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
    }
}

extension DisclosureGroupStyle where Self == BorderedButtonDisclosureGroupStyle {
    static var borderedButton: Self { .init() }
}
