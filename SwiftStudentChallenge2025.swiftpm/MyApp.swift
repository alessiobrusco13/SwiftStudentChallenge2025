import SwiftUI

@main
struct MyApp: App {
    @State private var model = Model()
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage(Model.activeProjectIDKey) private var activeProjectID: String?
    @AppStorage(Model.hasOnboardedKey) private var hasOnboarded = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if hasOnboarded {
                    ContentView()
                        .transition(.opacity)
                        .onAppear {
                            try? model.generateSampleData()
                        }
                } else {
                    OnboardingView()
                        .transition(.opacity)
                }
            }
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
