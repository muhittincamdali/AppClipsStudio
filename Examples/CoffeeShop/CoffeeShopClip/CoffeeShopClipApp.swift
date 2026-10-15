import SwiftUI

/// The App Clip. It is built from the same `Shared` sources as the full app, with the
/// `APPCLIP` compilation condition set for location confirmation and the App Store overlay.
@main
struct CoffeeShopClipApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
