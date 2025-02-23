//
//  TimeInterval+Components.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 23/02/25.
//

import Foundation

extension TimeInterval {
    func components() -> (hours: Int, minutes: Int, seconds: Int) {
        let hours = floor(self / (60*60))
        let minutes = floor((self - hours*60*60) / 60)
        let seconds = floor((self - hours*60*60) - minutes*60)
        
        return (Int(hours), Int(minutes), Int(seconds))
    }
}
