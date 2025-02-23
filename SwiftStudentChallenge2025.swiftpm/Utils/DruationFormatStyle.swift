//
//  Untitled.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 23/02/25.
//

import Foundation

struct DurationFormatStyle: FormatStyle {
    let addComma: Bool

    func format(_ value: TimeInterval) -> String {
        let components = value.components()
        let hoursString = "\(components.hours) hr"
        let minutesString = "\(components.minutes) min"
        
        if components.minutes == 0 {
            return hoursString
        } else if components.hours == 0 {
            return minutesString
        } else {
            return addComma ? "\(hoursString), \(minutesString)" : "\(hoursString) \(minutesString)"
        }
    }
}

extension FormatStyle where Self == DurationFormatStyle {
    static func duration(addComma: Bool) -> DurationFormatStyle {
        DurationFormatStyle(addComma: addComma)
    }
    
    static var duration: DurationFormatStyle {
        DurationFormatStyle(addComma: false)
    }
}
