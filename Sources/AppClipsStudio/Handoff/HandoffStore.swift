import Foundation

/// Passes a value from the App Clip to the full app through a shared App Group.
///
/// When someone installs the full app, it replaces the App Clip. Apple recommends storing what
/// the App Clip collected in a shared container or a shared `UserDefaults` suite so the full app
/// can pick it up. `HandoffStore` does that for any `Codable` value and adds what the plain
/// suite lacks: a schema version, an optional expiry date and a size limit that is checked
/// before anything is decoded.
///
/// ```swift
/// struct Cart: Codable, Sendable { var items: [String] }
///
/// let store = HandoffStore<Cart>(appGroup: "group.com.example.shop", key: "cart")
/// try store?.save(Cart(items: ["Latte"]), expiresAfter: 7 * 24 * 60 * 60)   // App Clip
/// let cart = try store?.take()                                              // full app
/// ```
///
/// Don't store passwords or other secrets this way; Apple recommends an anonymized identifier,
/// the keychain (shared from iOS 15.4) or Sign in with Apple instead.
public struct HandoffStore<Value: Codable & Sendable>: @unchecked Sendable {
    // UserDefaults is thread-safe; it is not marked Sendable in every SDK this package supports.
    private let defaults: UserDefaults
    private let key: String

    /// The version written with each value; a stored value with another version is not decoded.
    public let schemaVersion: Int
    /// The largest encoded value accepted, in bytes.
    public let maximumBytes: Int
    private let now: @Sendable () -> Date

    /// Creates a store on a `UserDefaults` instance.
    ///
    /// - Parameters:
    ///   - defaults: The shared suite, `UserDefaults(suiteName: "group.…")`.
    ///   - key: The defaults key.
    ///   - schemaVersion: Bump it when `Value` changes incompatibly.
    ///   - maximumBytes: The largest encoded value accepted; 64 KB by default.
    ///   - now: The clock used for expiry; tests pass a fixed date.
    public init(
        defaults: UserDefaults,
        key: String,
        schemaVersion: Int = 1,
        maximumBytes: Int = 64 * 1024,
        now: @escaping @Sendable () -> Date = { Date() }
    ) {
        self.defaults = defaults
        self.key = key
        self.schemaVersion = schemaVersion
        self.maximumBytes = maximumBytes
        self.now = now
    }

    /// Creates a store on the App Group's shared `UserDefaults` suite, or returns `nil` when the
    /// suite cannot be opened.
    public init?(appGroup: String, key: String, schemaVersion: Int = 1, maximumBytes: Int = 64 * 1024) {
        guard let defaults = UserDefaults(suiteName: appGroup) else { return nil }
        self.init(defaults: defaults, key: key, schemaVersion: schemaVersion, maximumBytes: maximumBytes)
    }

    /// Saves a value, replacing the previous one.
    ///
    /// - Parameters:
    ///   - value: The value to pass to the full app.
    ///   - expiresAfter: Seconds until the value is discarded on load; `nil` keeps it until it
    ///     is taken or cleared. Must be a finite, positive number.
    public func save(_ value: Value, expiresAfter: TimeInterval? = nil) throws(HandoffError) {
        let savedAt = now()
        var expiresAt: Date?
        if let expiresAfter {
            guard expiresAfter.isFinite, expiresAfter > 0 else { throw .invalidExpiry }
            expiresAt = savedAt.addingTimeInterval(expiresAfter)
        }
        let envelope = Envelope(version: schemaVersion, savedAt: savedAt, expiresAt: expiresAt, value: value)
        let data: Data
        do {
            data = try JSONEncoder().encode(envelope)
        } catch {
            throw .encodingFailed(String(describing: error))
        }
        guard data.count <= maximumBytes else {
            throw .tooLarge(bytes: data.count, limit: maximumBytes)
        }
        defaults.set(data, forKey: key)
    }

    /// The stored value, or `nil` when there is none or it has expired (an expired value is
    /// removed).
    public func load() throws(HandoffError) -> Value? {
        guard let data = defaults.data(forKey: key) else { return nil }
        guard data.count <= maximumBytes else {
            clear()
            throw .tooLarge(bytes: data.count, limit: maximumBytes)
        }
        let header: Header
        do {
            header = try JSONDecoder().decode(Header.self, from: data)
        } catch {
            throw .decodingFailed(String(describing: error))
        }
        guard header.version == schemaVersion else {
            throw .schemaMismatch(stored: header.version, expected: schemaVersion)
        }
        if let expiresAt = header.expiresAt, expiresAt <= now() {
            clear()
            return nil
        }
        do {
            return try JSONDecoder().decode(Envelope.self, from: data).value
        } catch {
            throw .decodingFailed(String(describing: error))
        }
    }

    /// Loads the stored value and removes it, so the full app imports it once.
    public func take() throws(HandoffError) -> Value? {
        let value = try load()
        clear()
        return value
    }

    /// Removes the stored value.
    public func clear() {
        defaults.removeObject(forKey: key)
    }

    private struct Header: Decodable {
        let version: Int
        let expiresAt: Date?
    }

    private struct Envelope: Codable {
        let version: Int
        let savedAt: Date
        let expiresAt: Date?
        let value: Value
    }
}

/// Why a handoff value could not be saved or loaded.
public enum HandoffError: Error, Sendable, Hashable {
    /// The expiry interval is zero, negative, infinite or NaN.
    case invalidExpiry
    /// The value could not be encoded.
    case encodingFailed(String)
    /// The encoded value is larger than the store's limit.
    case tooLarge(bytes: Int, limit: Int)
    /// The stored data is not a value this store wrote.
    case decodingFailed(String)
    /// The stored value was written with another schema version.
    case schemaMismatch(stored: Int, expected: Int)
}
