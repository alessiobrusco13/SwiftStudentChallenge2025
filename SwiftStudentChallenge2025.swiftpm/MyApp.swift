import SwiftUI

@main
struct MyApp: App {
    @State private var model = Model()
    @Environment(\.scenePhase) var scenePhase
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
                .onChange(of: scenePhase) {
                    if case .background = scenePhase {
                        model.shouldShowWelcomeScreen = true
                    }
                }
        }
    }
}
