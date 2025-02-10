//
//  HomeView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 09/02/25.
//

import SwiftUI

// [] Scroll lag when showing welcome message.

struct HomeView: View {
    @State private var topBarMinimized = false
    
    var body: some View {
        ScrollView {
            ForEach(0..<20, id: \.self) { i in
                Text("\(i)")
                    .padding(20)
                    .background(.red)
            }
            .compositingGroup()
        }
        .frame(maxWidth: .infinity)
        .safeAreaInset(edge: .top) {
            topBar
        }
        .onScrollGeometryChange(for: Double.self) { geometry in
            geometry.contentOffset.y + geometry.contentInsets.top
        } action: { oldValue, newValue in
            print(newValue)
            
            if newValue >= 20 {
                topBarMinimized = true
            } else if newValue <= 10 {
                topBarMinimized = false
            }
        }
    }
    
    var topBar: some View {
        TopBar(minimized: $topBarMinimized) {
            Button {
                
            } label: {
                
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(Model.preview)
}
