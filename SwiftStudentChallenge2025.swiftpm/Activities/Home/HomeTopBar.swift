//
//  HomeTopBar.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 09/02/25.
//

import SwiftUI

// [~] Custom Title View that starts off with a greeting and becomes date.
// [X] ~Variable Blur background.
// [X] Minimisation on scroll.
// [X] Date format localisation.

struct HomeTopBar<Content: View>: View {
    let isMinimized: Bool
    @ViewBuilder let content: () -> Content
    
    @Environment(Model.self) private var model
    @State private var showingWelcome = false
    
    var formattedDate: String {
        Date.now.formatted(.dateTime.locale(.autoupdatingCurrent).day().month(.wide))
    }
    
    var welcomeText: String {
        "Welcome Back!"
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if showingWelcome && !isMinimized {
                    Text(welcomeText)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Lucid")
                        .font((showingWelcome || isMinimized) ? .headline : .largeTitle)
                        .foregroundStyle((showingWelcome && !isMinimized) ?  .secondary : .primary)
                    
                    
                    Text(formattedDate)
                        .font((showingWelcome || isMinimized) ? .callout : .title2)
                        .foregroundStyle((showingWelcome && !isMinimized) ?  .tertiary : .secondary)
                }
                .fontWeight(.bold)
            }
            
            Spacer()
            
            content()
        }
        .animation(.bouncy, value: showingWelcome)
        .task {
            guard model.shouldShowWelcomeScreen else { return }
            
            showingWelcome = true
            try? await Task.sleep(for: .seconds(2))
            showingWelcome = false
            
            model.shouldShowWelcomeScreen = false
        }
    }
}

#Preview {
    @Previewable @State var isMinimized = false
    
    ZStack {
        VStack {
            HomeTopBar(isMinimized: isMinimized) {
                Button {
                    
                } label: {
                    Image(systemName: "gear")
                        .font(.title3)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.glass)
            }
            
            Spacer()
            
            HStack {
                Button("Toggle Minimization") {
                    isMinimized.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
    .environment(Model.preview)
}
