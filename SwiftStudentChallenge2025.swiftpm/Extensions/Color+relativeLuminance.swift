//
//  Color+relativeLuminance.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

extension Color {
    func relativeLuminance(in environment: EnvironmentValues) -> Double {
        let resolved = resolve(in: environment)
        return 0.2126 * Double(resolved.red) + 0.7152 * Double(resolved.green) + 0.0722 * Double(resolved.blue)
    }
    
    var relativeLuminance: Double {
        relativeLuminance(in: .init())
    }
}
