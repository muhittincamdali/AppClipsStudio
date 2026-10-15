import SwiftUI

/// The full app. It replaces the App Clip once installed, so it handles the same invocation
/// URLs and imports the order the App Clip left in the shared App Group.
@main
struct CoffeeShopApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
