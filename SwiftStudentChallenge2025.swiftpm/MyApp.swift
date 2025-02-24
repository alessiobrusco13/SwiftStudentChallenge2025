import SwiftUI

// – [~] App name
// – [] App icon
// – [] Essays

// – [X] Fix background view (use a timeline view)
// – [] Project Creation (Ask 'what are you doing this for?' 'Other times this has gone through' etc)
// – [] iPad optimization (what to show alongside the projects)
// – [] Onboarding
// ? [] VoiceOver

// – [] Consider removing Today Title and having a different way of showing time
    
// – [] Inside Project view
//  – [X] solo la prossima task + modo per vedere le altre
//  – [] perché stai studiando questa roba? (motivazionale)
//  – [X] pulsante per iniziare e smettere di lockarsi
//  – [] ricordare di fare pause
//  – [X + ~] resoconto mood nel mentre (mindfulness tab)
//  – [] invitare a pensare al perché delle cose (perché sto per procrastinare) magari quando si clicca il pulsante per fermarsi
//  – [X + ~] Feelings section, encourage reflection. ~ Sentiment Analysis

// – [] NEGRO Natural language sentiment analysis

// – [X] Metti a posto emotion logger,.

// MARK: VEDI magari fai che quando ti locki ti compare una schermata fissa (magari animata) e quando provi a fare pausa ti dice no no no, troppo poco tempo.

@main
struct MyApp: App {
    @State private var model = Model.preview
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage(Model.activeProjectIDKey) private var activeProjectID: String?
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(model)
                .modelContainer(model.container)
                .onChange(of: scenePhase) {
                    if case .background = scenePhase {
                        model.shouldShowWelcomeScreen = true
                        if activeProjectID != nil {
                            Task {
                                await model.notificationManager.scheduleNotification(ofKind: .appQuitDuringSession)
                            }
                        }
                        
                    }
                }
                .task {
                    Task { @MainActor in
                        await model.notificationManager.requestAuthorization()
                    }
                }
        }
    }
}
