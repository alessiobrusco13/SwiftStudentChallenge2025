//
//  GlassAlert.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 24/02/25.
//

import SwiftUI

struct GlassAlert<Actions: View>: View {
    let title: String
    let message: String
    
    @ViewBuilder let actions: () -> Actions
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text(title)
                    .lineLimit(2, reservesSpace: true)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(message)
                    .lineLimit(3, reservesSpace: true)
            }
            .multilineTextAlignment(.center)
            .padding([.top, .horizontal])
            
            Divider()
            
            actions()
            .padding([.bottom, .horizontal])
        }
        .background(.glass(shadowRadius: 10), in: .rect(cornerRadius: 32))
        .colorScheme(.dark)
        .compositingGroup()
        .frame(maxWidth: 270)
        .padding()
    }
}

struct GlassAlertViewModifier<Actions: View>: ViewModifier {
    let title: String
    @Binding var isPresented: Bool
    let message: String
    let dismissiveBackground: Bool
    @ViewBuilder let actions: () -> Actions
    
    func body(content: Content) -> some View {
        content
            .animation(.smooth, value: isPresented)
            .fullScreenCover(isPresented: $isPresented) {
                GlassAlert(title: title, message: message, actions: actions)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .presentationBackground {
                    ProgressiveBlur()
                        .ignoresSafeArea()
                        .onTapGesture {
                            if dismissiveBackground {
                                isPresented = false
                            }
                        }
                }
            }
    }
}

extension View {
    func glassAlert<Actions: View>(
        _ title: String,
        isPresented: Binding<Bool>,
        message: String,
        dismissiveBackground: Bool = true,
        @ViewBuilder actions: @escaping ()  -> Actions
    ) -> some View {
        modifier(
            GlassAlertViewModifier(
                title: title,
                isPresented: isPresented,
                message: message,
                dismissiveBackground: dismissiveBackground,
                actions: actions
            )
        )
    }
}
