#if os(iOS) && canImport(StoreKit) && canImport(SwiftUI)
import StoreKit
import SwiftUI

extension View {
    /// Shows the App Store overlay that recommends the App Clip's full app.
    ///
    /// Present it after the person finished the task they came for, such as after the order
    /// confirmation, not on launch. Use it in the App Clip target only: the overlay's
    /// configuration describes the App Clip's parent app.
    ///
    /// - Parameters:
    ///   - isPresented: Whether the overlay is visible; the system sets it to `false` when the
    ///     person dismisses it.
    ///   - position: Where the overlay appears.
    public func fullAppOverlay(isPresented: Binding<Bool>, position: SKOverlay.Position = .bottom) -> some View {
        appStoreOverlay(isPresented: isPresented) {
            SKOverlay.AppClipConfiguration(position: position)
        }
    }
}
#endif
