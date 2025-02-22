//
//  StartSessionView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 22/02/25.
//

import SwiftUI

struct StartSessionView: View {
    @Binding var isExpanded: Bool
    @Namespace private var namespace
    
    var body: some View {
        if !isExpanded {
            ZStack(alignment: .bottom) {
                ProgressiveBlur()
                    .ignoresSafeArea()
                    .frame(maxHeight: 70)
                
                startButton
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.glass)
                    .ignoresSafeArea()
                    .frame(maxHeight: 270)
                
                Text("I Love Studying And stuff")
            }
            .overlay(alignment: .topTrailing) {
                startButtonItem
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
    
    private var startButton: some View {
        Button {
            withAnimation(.bouncy) {
                isExpanded.toggle()
            }
        } label: {
            Label("Start Study Session", systemImage: "play.fill")
                .font(.headline)
                .padding(12)
                .frame(maxWidth: 350)
        }
        .buttonBorderShape(.roundedRectangle(radius: 24))
        .buttonStyle(.prominentGlass)
        .shadow(color: .black.opacity(0.2), radius: 10)
        .padding(.horizontal)
        .matchedGeometryEffect(id: "startButton", in: namespace)
    }
    
    private var startButtonItem: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            Label("Start", systemImage: "play.fill")
                .font(.headline)
                .fixedSize()
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(.prominentGlass)
        .padding(.horizontal)
        .matchedGeometryEffect(id: "startButton", in: namespace)
        .padding(.top)
    }
}
