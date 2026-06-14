#if os(iOS)
import Foundation
import StoreKit

/// Main entry point for AppClipsStudio.
public enum AppClipsStudio {
    public static let version = "2.0.0"
}

/// Helper to display the SKOverlay for App Clip conversion.
@MainActor
public struct AppClipConversion {
    public static func showAppStoreOverlay(appIdentifier: String) {
        #if os(iOS) && !targetEnvironment(macCatalyst)
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let config = SKOverlay.AppClipConfiguration(position: .bottom)
        let overlay = SKOverlay(configuration: config)
        overlay.present(in: scene)
        #endif
    }
}
#endif
