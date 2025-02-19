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
//                    .shadow(
//                        .inner(
//                            color: .white.opacity(0.4),
//                            radius: 0.8,
//                            x: 0.5,
//                            y: 0.5
//                        )
//                    )
            .shadow(
                .drop(
                    color: .white.opacity(0.25),
                    radius: 0.5,
                    x: -0.4,
                    y: -0.5
                )
            )
        
    }
    
    static func glass(shadowRadius: Double = 10, opacity: Double = 1) -> some ShapeStyle {
        Material.ultraThinMaterial
            .shadow(
                .drop(
                    color: .white.opacity(0.4),
                    radius: 0.5,
                    x: -0.4,
                    y: -0.5
                )
            )
            .shadow(
                .drop(
                    color: .black.opacity(0.2),
                    radius: shadowRadius,
                    x: 3,
                    y: 3
                )
            )
            .opacity(opacity)
    }
}

extension ShapeStyle where Self == _ShadowShapeStyle<_ShadowShapeStyle<Material>> {
    static var prominentGlass: some ShapeStyle {
        Material.thinMaterial
            .shadow(
                .drop(
                    color: .white.opacity(0.4),
                    radius: 0.5,
                    x: -0.4,
                    y: -0.5
                )
            )
    }
    
    static func prominentGlass(shadowRadius: Double = 10, opacity: Double = 1) -> some ShapeStyle {
        Material.thinMaterial
            .shadow(
                .drop(
                    color: .white.opacity(0.4),
                    radius: 0.5,
                    x: -0.4,
                    y: -0.5
                )
            )
            .shadow(
                .drop(
                    color: .black.opacity(0.2),
                    radius: shadowRadius,
                    x: 3,
                    y: 3
                )
            )
            .opacity(opacity)
    }
}
