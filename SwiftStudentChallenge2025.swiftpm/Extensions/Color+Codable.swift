//
//  Color+Codable.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

extension Color: Codable {
    enum CodingKeys: CodingKey {
        case r, g, b, a
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .r)
        let g = try container.decode(Double.self, forKey: .g)
        let b = try container.decode(Double.self, forKey: .b)
        let a = try container.decode(Double.self, forKey: .a)
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let resolved = resolve(in: EnvironmentValues())
        
        try container.encode(resolved.red, forKey: .r)
        try container.encode(resolved.green, forKey: .g)
        try container.encode(resolved.blue, forKey: .b)
        try container.encode(resolved.opacity, forKey: .a)
    }
}
