//
//  AnimatedBackgroundView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 12/02/25.
//

import SwiftUI

struct AnimatedBackgroundView: View {
    @State var time: Float = 0.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            MeshGradient(width: 3, height: 3, points: [
                .init(0, 0), .init(0.5, 0), .init(1, 0),
                
                [sinWave(in: -0.8...(-0.3), phaseShift: 0.515, frequency: 0.342), sinWave(in: 0.4...1.0, phaseShift: 2.067, frequency: 0.096)],
                [sinWave(in: 0.2...0.8, phaseShift: 0.841, frequency: 0.562), sinWave(in: 0.5...1.0, phaseShift: 3.956, frequency: 0.788)],
                [sinWave(in: 1.0...1.3, phaseShift: 0.746, frequency: 0.431), sinWave(in: 0.3...0.8, phaseShift: 0.289, frequency: 0.521)],
                
                [sinWave(in: -0.7...0.0, phaseShift: 1.329, frequency: 0.412), sinWave(in: 1.2...1.8, phaseShift: 3.245, frequency: 0.897)],
                [sinWave(in: 0.3...0.7, phaseShift: 0.329, frequency: 0.451), sinWave(in: 0.9...1.1, phaseShift: 1.122, frequency: 0.693)],
                [sinWave(in: 0.9...1, phaseShift: 0.902, frequency: 0.056), sinWave(in: 1.2...1.3, phaseShift: 0.043, frequency: 0.247)]
            ], colors: [
                .pink.opacity(0.4), .yellow.opacity(0.4), .indigo.opacity(0.4),
                .orange.opacity(0.5), .black, .purple.opacity(0.5),
                .mint.opacity(0.4), .white.opacity(0.6), .black
            ])
            .onChange(of: timeline.date) { oldValue, newValue in
                time += Float(newValue.timeIntervalSince(oldValue))*0.5
            }
        }
        .background(.black)
        .ignoresSafeArea()
        .clipShape(.rect(cornerRadius: 20))
        .padding(-5)
        .blur(radius: 5)
    }
    
    func sinWave(in range: ClosedRange<Float>, phaseShift: Float, frequency: Float) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2
        
        return midPoint + amplitude * sin(frequency * time + phaseShift)
    }
}

#Preview {
    AnimatedBackgroundView()
        .ignoresSafeArea()
}
