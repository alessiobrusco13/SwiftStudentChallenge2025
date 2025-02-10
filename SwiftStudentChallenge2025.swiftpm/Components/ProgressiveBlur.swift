//
//  ProgressiveBlur.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 09/02/25.
//

import SwiftUI

struct ProgressiveBlur: View {
    var body: some View {
        TransparentViewRepresentable()
            .blur(radius: 10)
    }
}

fileprivate class TransparentView: UIVisualEffectView {
    init() {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        removeFilters()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (traitEnvironment: TransparentView, _) in
            Task { @MainActor in
                traitEnvironment.removeFilters()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeFilters() {
        layer.sublayers?.first?.filters?.removeAll()
    }
}

fileprivate struct TransparentViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some TransparentView {
        let view = TransparentView()
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
