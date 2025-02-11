//
//  ToggleOnScrolldownModifier.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 11/02/25.
//

import SwiftUI

struct ToggleOnScrollModifier: ViewModifier {
    @Binding var state: Bool
    
    func body(content: Content) -> some View {
        content
            .onScrollGeometryChange(for: Double.self) { geometry in
                geometry.contentOffset.y + geometry.contentInsets.top
            } action: { _, newValue in
                if newValue >= 20 {
                    state = true
                } else if newValue <= 10 {
                    state = false
                }
            }
    }
}

extension View {
    func toggleOnScroll(_ state: Binding<Bool>) -> some View {
        modifier(ToggleOnScrollModifier(state: state))
    }
}
