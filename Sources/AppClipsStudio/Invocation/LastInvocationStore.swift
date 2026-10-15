import Foundation

/// Remembers the last invocation URL, for launches that arrive without one.
///
/// When a person returns to an App Clip from a notification or the App Switcher, it launches
/// without an invocation URL. Apple recommends saving the App Clip's state and restoring it in
/// that case. Save each invocation you handle, and load it when
/// ``Invocation/init(userActivity:limits:)`` throws ``InvocationError/missingURL`` or the app
/// starts without an activity.
///
/// The stored URL is validated again on load, so a value written by an older version of your
/// App Clip, or edited on disk, never skips the checks.
public struct LastInvocationStore: @unchecked Sendable {
    // UserDefaults is thread-safe; it is not marked Sendable in every SDK this package supports.
    private let defaults: UserDefaults
    private let key: String

    /// Creates a store.
    ///
    /// - Parameters:
    ///   - defaults: Where to keep the URL. Use the App Group suite you share with the full app
    ///     so the full app can resume where the App Clip left off.
    ///   - key: The defaults key.
    public init(defaults: UserDefaults = .standard, key: String = "AppClipsStudio.lastInvocation") {
        self.defaults = defaults
        self.key = key
    }

    /// Saves the invocation's URL, replacing the previous one.
    public func save(_ invocation: Invocation) {
        defaults.set(invocation.url.absoluteString, forKey: key)
    }

    /// The last saved invocation, or `nil` when there is none or it no longer passes the checks.
    public func load(limits: InvocationLimits = .standard) -> Invocation? {
        guard let text = defaults.string(forKey: key),
              text.utf8.count <= limits.maximumURLLength,
              let url = URL(string: text) else {
            return nil
        }
        return try? Invocation(url: url, limits: limits)
    }

    /// Removes the saved URL.
    public func clear() {
        defaults.removeObject(forKey: key)
    }
}
