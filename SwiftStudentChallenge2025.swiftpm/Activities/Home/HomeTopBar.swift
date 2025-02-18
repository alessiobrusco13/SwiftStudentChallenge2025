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
    let minimized: Bool
    @ViewBuilder let content: () -> Content
    
    @Environment(Model.self) private var model
    @State private var showingWelcome = false
    
    var formattedDate: String {
        Date.now.formatted(.dateTime.locale(.autoupdatingCurrent).day().month(.wide))
    }
    
    var welcomeText: String {
        "Hey! I knew you'd show up ⭐"
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if showingWelcome && !minimized {
                    Text(welcomeText)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Today")
                        .font((showingWelcome || minimized) ? .title3 : .largeTitle)
                        .foregroundStyle((showingWelcome && !minimized) ?  .secondary : .primary)
                    
                    
                    Text(formattedDate)
                        .font((showingWelcome || minimized) ? .body : .title2)
                        .foregroundStyle((showingWelcome && !minimized) ?  .tertiary : .secondary)
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
    @Previewable @State var minimized = false
    
    ZStack {
        VStack {
            HomeTopBar(minimized: minimized) {
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
                    minimized.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
    .environment(Model.preview)
}
