import SwiftUI

// – [] iPad optimization
//
    
@main
struct MyApp: App {
    @State private var model = Model.preview
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(model)
                .modelContainer(model.container)
                .onChange(of: scenePhase) {
                    if case .background = scenePhase {
                        model.shouldShowWelcomeScreen = true
                    }
                }
        }
    }
}
