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
    @Binding var minimized: Bool
    @ViewBuilder let content: (Bool) -> Content
    
    @Environment(\.locale) private var locale
    
    var body: some View {
        HStack {
            content(minimized)
        }
        .padding(.horizontal)
        .padding(.vertical, minimized ? 4 : 10)
        .frame(maxWidth: .infinity)
        .background {
            ProgressiveBlur()
                .padding(.top, -100)
                .ignoresSafeArea()
        }
        .animation(.default, value: minimized)
    }
}

fileprivate struct TopBarModifier<TopBarContent: View>: ViewModifier {
    @State private var minimized = false
    
    var behavior: TopBarBehavior
    @ViewBuilder let topBarContent: (Bool) -> TopBarContent
    
    private var minimizedBinding: Binding<Bool> {
        switch behavior {
        case .alwaysMinimized:
                .constant(true)
        case .neverMinimized:
                .constant(false)
        case .standard:
            $minimized
        }
    }
    
    func body(content: Content) -> some View {
        content
            .toggleOnScroll(minimizedBinding)
            .safeAreaInset(edge: .top) {
                TopBar(minimized: minimizedBinding, content: topBarContent)
            }
    }
}

extension View {
    func topBar(title: String, behavior: TopBarBehavior = .standard) -> some View {
        modifier(
            TopBarModifier<AnyView>(behavior: behavior) { minimized in
                AnyView(
                    Text(title)
                        .font(minimized ? .body : .largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: minimized ? .center : .leading)
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
//            TopBarModifier<Content>(behavior: behavior) { minimized in
//                content(
//                    AnyView(
//                        Text(title)
//                            .font(minimized ? .title3 : .largeTitle)
//                            .bold()
//                            .frame(maxWidth: .infinity, alignment: minimized ? .center : .leading)
//                    )
//                )
//            }
//        )
//    }
    
    func topBar<Content: View>(behavior: TopBarBehavior = .standard, @ViewBuilder content: @escaping (_ minimized: Bool) -> Content) -> some View {
        modifier(TopBarModifier(behavior: behavior, topBarContent: content))
    }
}
