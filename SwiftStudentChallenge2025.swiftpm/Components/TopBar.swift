//
//  TopBar.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 09/02/25.
//

import SwiftUI

enum TopBarBehavior {
    case alwaysMinimized, neverMinimized, standard
}

fileprivate struct TopBar<Content: View>: View {
    @Binding var isMinimized: Bool
    @ViewBuilder let content: (Bool) -> Content
    
    @Environment(\.locale) private var locale
    
    var body: some View {
        HStack {
            content(isMinimized)
        }
        .padding(.horizontal)
        .padding(.vertical, isMinimized ? 4 : 10)
        .frame(maxWidth: .infinity)
        .background {
            ProgressiveBlur()
                .padding(.top, -100)
                .ignoresSafeArea()
        }
        .animation(.default, value: isMinimized)
    }
}

fileprivate struct TopBarModifier<TopBarContent: View>: ViewModifier {
    @State private var isMinimized = false
    
    var behavior: TopBarBehavior
    @ViewBuilder let topBarContent: (Bool) -> TopBarContent
    
    private var isMinimizedBinding: Binding<Bool> {
        switch behavior {
        case .alwaysMinimized:
                .constant(true)
        case .neverMinimized:
                .constant(false)
        case .standard:
            $isMinimized
        }
    }
    
    func body(content: Content) -> some View {
        content
            .toggleOnScroll(isMinimizedBinding)
            .safeAreaInset(edge: .top) {
                TopBar(isMinimized: isMinimizedBinding, content: topBarContent)
            }
    }
}

extension View {
    func topBar(title: String, behavior: TopBarBehavior = .standard) -> some View {
        modifier(
            TopBarModifier<AnyView>(behavior: behavior) { isMinimized in
                AnyView(
                    Text(title)
                        .font(isMinimized ? .body : .largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: isMinimized ? .center : .leading)
                )
            }
        )
    }
    
//    func topBar<Content: View>(
//        title: String,
//        behavior: TopBarBehavior = .standard,
//        @ViewBuilder content: @escaping (_ title: AnyView) -> Content
//    ) -> some View {
//        modifier(
//            TopBarModifier<Content>(behavior: behavior) { isMinimized in
//                content(
//                    AnyView(
//                        Text(title)
//                            .font(isMinimized ? .title3 : .largeTitle)
//                            .bold()
//                            .frame(maxWidth: .infinity, alignment: isMinimized ? .center : .leading)
//                    )
//                )
//            }
//        )
//    }
    
    func topBar<Content: View>(behavior: TopBarBehavior = .standard, @ViewBuilder content: @escaping (_ isMinimized: Bool) -> Content) -> some View {
        modifier(TopBarModifier(behavior: behavior, topBarContent: content))
    }
}
