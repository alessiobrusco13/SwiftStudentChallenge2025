//
//  Thin.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 13/02/25.
//

import SwiftUI

extension ShapeStyle where Self == _ShadowShapeStyle<_ShadowShapeStyle<Material>> {
    static var glass: some ShapeStyle {
        Material.ultraThinMaterial
            .shadow(
                .inner(
                    color: .white.opacity(0.3),
                    radius: 0.8,
                    x: 0.5,
                    y: 0.5
                )
            )
            .shadow(
                .drop(
                    color: .black.opacity(0.2),
                    radius: 10,
                    x: 3,
                    y: 3
                )
            )
    }
}

extension ShapeStyle where Self == _ShadowShapeStyle<_ShadowShapeStyle<Material>> {
    static var prominentGlass: some ShapeStyle {
        Material.thinMaterial
            .shadow(
                .inner(
                    color: .white.opacity(0.4),
                    radius: 0.8,
                    x: 0.5,
                    y: 0.5
                )
            )
            .shadow(
                .drop(
                    color: .black.opacity(0.2),
                    radius: 10,
                    x: 3,
                    y: 3
                )
            )
    }
}
