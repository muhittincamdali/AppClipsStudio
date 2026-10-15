import Foundation

extension Invocation {
    /// Creates an invocation from the user activity the system passes on launch.
    ///
    /// Throws ``InvocationError/notBrowsingWeb(activityType:)`` for other activity types and
    /// ``InvocationError/missingURL`` when the activity carries no URL, which happens when a
    /// person returns to the App Clip from a notification or the App Switcher. In that case,
    /// restore the state you saved instead; see ``LastInvocationStore``.
    public init(userActivity: NSUserActivity, limits: InvocationLimits = .standard) throws(InvocationError) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            throw .notBrowsingWeb(activityType: userActivity.activityType)
        }
        guard let url = userActivity.webpageURL else {
            throw .missingURL
        }
        try self.init(url: url, limits: limits)
    }
}

#if canImport(SwiftUI)
import SwiftUI

extension View {
    /// Calls `perform` with each validated invocation the scene receives.
    ///
    /// Attach it to the root view of both the App Clip and the full app: once the full app is
    /// installed, it replaces the App Clip and receives every invocation in its place.
    /// Activities that fail validation go to `rejected`, which does nothing by default.
    ///
    /// - Parameters:
    ///   - limits: The bounds each invocation URL must stay within.
    ///   - perform: Called on the main actor with the validated invocation.
    ///   - rejected: Called with the reason an activity was not accepted.
    public func onInvocation(
        limits: InvocationLimits = .standard,
        perform: @escaping (Invocation) -> Void,
        rejected: @escaping (InvocationError) -> Void = { _ in }
    ) -> some View {
        onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
            do throws(InvocationError) {
                perform(try Invocation(userActivity: activity, limits: limits))
            } catch {
                rejected(error)
            }
        }
    }
}
#endif
