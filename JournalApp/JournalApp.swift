import SwiftUI
import SwiftData

@main
struct JournalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainTabView() // Switch to your new TabView
                .modelContainer(for: [JournalEntry.self])
        }
    }
}

