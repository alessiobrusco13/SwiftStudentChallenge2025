import SwiftUI

// – [] App name
// – [] Essays

// – [] Session Creation
// – [] Fix background view (use a timeline view)
// – [] Inside Session view
// – [] Session Cration (Ask 'what are you doing this for?' 'Other times this has gone through' etc)
// – [] iPad optimization (what to show alongside the sessions)
// – [] Onboarding
// ? [] VoiceOver

// – [] Consider removing Today Title and having a different way of showing time
    
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
