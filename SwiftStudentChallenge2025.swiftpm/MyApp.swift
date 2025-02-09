import SwiftUI

@main
struct MyApp: App {
    @State private var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}
