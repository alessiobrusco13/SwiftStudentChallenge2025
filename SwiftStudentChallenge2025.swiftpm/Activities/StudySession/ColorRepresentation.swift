//
//  ColorRepresentation.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

struct ColorRepresentation: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let opacity: Double
    
    init(of color: Color, in environment: EnvironmentValues = .init()) {
        let resolved = color.resolve(in: environment)
        
        self.red = Double(resolved.red)
        self.green = Double(resolved.green)
        self.blue = Double(resolved.blue)
        self.opacity = Double(resolved.opacity)
    }
    
    init(red: Double, green: Double, blue: Double, opacity: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
    
    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}
