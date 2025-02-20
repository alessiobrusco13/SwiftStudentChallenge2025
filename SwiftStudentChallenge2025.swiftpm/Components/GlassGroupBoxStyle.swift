//
//  GlassGroupBoxStyle.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 20/02/25.
//

import SwiftUI

struct GlassGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.title3.weight(.bold))
            
            configuration.content
                .padding(.top, 5)
        }
        .padding()
        .background(.glass, in: .rect(cornerRadius: 24))
    }
}

extension GroupBoxStyle where Self == GlassGroupBoxStyle {
    static var glass: Self { .init() }
}
