import SwiftUI

// – [] App name
// – [] App icon
// – [] Essays

// – [] Fix background view (use a timeline view)
// – [] Session Cration (Ask 'what are you doing this for?' 'Other times this has gone through' etc)
// – [] iPad optimization (what to show alongside the sessions)
// – [] Onboarding
// ? [] VoiceOver

// – [] Consider removing Today Title and having a different way of showing time
    
// – [] Inside Session view
//  – [X] solo la prossima task + modo per vedere le altre
//  – [] perché stai studiando questa roba? (motivazionale)
//  – [] pulsante per iniziare e smettere di lockarsi
//  – [] ricordare di fare pause
//  – [] resoconto mood nel mentre
//  – [] invitare a pensare al perché delle cose (perché sto per procrastinare) magari quando si clicca il pulsante per fermarsi

// – [] NEGRO Natural language sentiment analysis

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
