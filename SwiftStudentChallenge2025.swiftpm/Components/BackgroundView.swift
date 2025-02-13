//
//  BackgroundView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 12/02/25.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        MeshGradient(
            width: 2, height: 2,
            points: [
                [0, 0], [1, 0], [0, 1], [1, 1]
            ],
            colors: [.black, .gray, .gray.opacity(0.7), .black.opacity(0.7)]
        )
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
