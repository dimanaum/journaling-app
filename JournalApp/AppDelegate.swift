import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Customize the tab bar globally
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
        UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray
        return true
    }
}

