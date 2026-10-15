import Foundation

/// A validated App Clip invocation URL, split into the parts an App Clip routes on.
///
/// The system passes the invocation URL to the App Clip (and to the full app once it replaces
/// the App Clip) in an `NSUserActivity` of type `NSUserActivityTypeBrowsingWeb`. `Invocation`
/// checks that URL before any of it reaches your code: it must use `https`, have a host, stay
/// within ``InvocationLimits`` and contain no `.` or `..` path components and no control or
/// format characters in the host, the path or the query once decoded. Path components and query
/// values are percent-decoded; an encoded slash (`%2F`) stays inside its component.
///
/// The default App Clip link that App Store Connect generates,
/// `https://appclip.apple.com/id?p=<bundle ID>&key=value`, is recognized: its `p` item must be
/// a bundle identifier, is reported as ``defaultLinkBundleIdentifier`` and is left out of
/// ``queryItems``.
public struct Invocation: Sendable, Hashable {
    /// The host of Apple's default App Clip links.
    public static let defaultLinkHost = "appclip.apple.com"

    /// The URL exactly as it was passed in.
    public let url: URL

    /// The host in lowercase, without a trailing dot.
    public let host: String

    /// The decoded, non-empty path components; `https://example.com/menu/lunch` gives
    /// `["menu", "lunch"]`.
    public let pathComponents: [String]

    /// The decoded query items in their original order.
    public let queryItems: [URLQueryItem]

    /// The App Clip bundle identifier of a default App Clip link, otherwise `nil`.
    public let defaultLinkBundleIdentifier: String?

    /// Creates an invocation from a URL, or throws the first check it fails.
    public init(url: URL, limits: InvocationLimits = .standard) throws(InvocationError) {
        let length = url.absoluteString.utf8.count
        guard length <= limits.maximumURLLength else {
            throw .urlTooLong(length: length, limit: limits.maximumURLLength)
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw .malformedURL
        }
        guard components.scheme?.lowercased() == "https" else {
            throw .unsupportedScheme(components.scheme)
        }
        let host = Self.normalizedHost(components.host)
        guard !host.isEmpty else { throw .missingHost }
        guard !host.unicodeScalars.contains(where: Self.isHidden) else {
            throw .invalidHost(components.percentEncodedHost ?? "")
        }

        let path = try Self.decodedPath(components.percentEncodedPath, limits: limits)
        var items = try Self.decodedQuery(components, limits: limits)

        var bundleIdentifier: String?
        if host == Self.defaultLinkHost, path == ["id"],
           let index = items.firstIndex(where: { $0.name == "p" }) {
            let value = items[index].value ?? ""
            guard AppIdentifier.isValidBundleIdentifier(value) else {
                throw .invalidBundleIdentifier(value)
            }
            bundleIdentifier = value
            items.remove(at: index)
        }

        self.url = url
        self.host = host
        self.pathComponents = path
        self.queryItems = items
        self.defaultLinkBundleIdentifier = bundleIdentifier
    }

    /// Whether this is a default App Clip link (`https://appclip.apple.com/id?p=…`).
    public var isDefaultAppClipLink: Bool {
        defaultLinkBundleIdentifier != nil
    }

    /// The value of the first query item with this name, or `nil` when there is none or it has
    /// no value.
    public func queryValue(_ name: String) -> String? {
        queryItems.first { $0.name == name }?.value
    }

    /// The values of every query item with this name, in order, skipping items without a value.
    public func queryValues(_ name: String) -> [String] {
        queryItems.filter { $0.name == name }.compactMap(\.value)
    }

    /// The host in lowercase, without a trailing dot, as hosts are compared everywhere.
    static func normalizedHost(_ host: String?) -> String {
        var host = (host ?? "").lowercased()
        if host.hasSuffix(".") {
            host.removeLast()
        }
        return host
    }

    /// Control and format characters, such as a decoded `%0A` or a bidirectional override, have
    /// no place in a path and could reach logs or the screen.
    private static func isHidden(_ scalar: Unicode.Scalar) -> Bool {
        switch scalar.properties.generalCategory {
        case .control, .format, .lineSeparator, .paragraphSeparator: true
        default: false
        }
    }

    private static func decodedQuery(
        _ components: URLComponents,
        limits: InvocationLimits
    ) throws(InvocationError) -> [URLQueryItem] {
        let items = components.queryItems ?? []
        guard items.count <= limits.maximumQueryItems else {
            throw .tooManyQueryItems(count: items.count, limit: limits.maximumQueryItems)
        }
        let encoded = components.percentEncodedQueryItems ?? []
        for (index, item) in items.enumerated() {
            let text = item.name + (item.value ?? "")
            guard text.unicodeScalars.contains(where: Self.isHidden) else { continue }
            throw .invalidQueryItem(index < encoded.count ? encoded[index].name : item.name)
        }
        return items
    }

    private static func decodedPath(
        _ encodedPath: String,
        limits: InvocationLimits
    ) throws(InvocationError) -> [String] {
        let encoded = encodedPath.split(separator: "/", omittingEmptySubsequences: true)
        guard encoded.count <= limits.maximumPathComponents else {
            throw .tooManyPathComponents(count: encoded.count, limit: limits.maximumPathComponents)
        }
        var decoded: [String] = []
        decoded.reserveCapacity(encoded.count)
        for component in encoded {
            guard let value = String(component).removingPercentEncoding,
                  !value.isEmpty, value != ".", value != "..",
                  !value.unicodeScalars.contains(where: Self.isHidden) else {
                throw .invalidPathComponent(String(component))
            }
            decoded.append(value)
        }
        return decoded
    }
}

/// Upper bounds that ``Invocation`` enforces before it parses a URL.
///
/// Invocation URLs come from App Clip Codes, NFC tags, QR codes, Messages and websites, so they
/// are untrusted input. The limits keep a hostile URL from making the App Clip do unbounded work.
public struct InvocationLimits: Sendable, Hashable {
    /// The longest accepted URL, in UTF-8 bytes of its absolute string.
    public var maximumURLLength: Int
    /// The most path components accepted.
    public var maximumPathComponents: Int
    /// The most query items accepted.
    public var maximumQueryItems: Int

    /// Creates limits; the defaults are far above what a real invocation URL needs.
    public init(maximumURLLength: Int = 2048, maximumPathComponents: Int = 32, maximumQueryItems: Int = 64) {
        self.maximumURLLength = maximumURLLength
        self.maximumPathComponents = maximumPathComponents
        self.maximumQueryItems = maximumQueryItems
    }

    /// 2,048 bytes, 32 path components and 64 query items.
    public static let standard = InvocationLimits()
}

/// Why a URL or user activity was not accepted as an invocation.
public enum InvocationError: Error, Sendable, Hashable {
    /// The user activity is not of type `NSUserActivityTypeBrowsingWeb`.
    case notBrowsingWeb(activityType: String)
    /// The user activity has no `webpageURL`, as when an App Clip is reopened from a
    /// notification or the App Switcher.
    case missingURL
    /// The URL cannot be split into components.
    case malformedURL
    /// The scheme is not `https`.
    case unsupportedScheme(String?)
    /// The URL has no host.
    case missingHost
    /// The host is not one of the router's allowed hosts.
    case hostNotAllowed(String)
    /// The URL is longer than ``InvocationLimits/maximumURLLength``.
    case urlTooLong(length: Int, limit: Int)
    /// The path has more components than ``InvocationLimits/maximumPathComponents``.
    case tooManyPathComponents(count: Int, limit: Int)
    /// The query has more items than ``InvocationLimits/maximumQueryItems``.
    case tooManyQueryItems(count: Int, limit: Int)
    /// A path component is `.`, `..`, not valid percent-encoding, or contains a control or
    /// format character once decoded.
    case invalidPathComponent(String)
    /// The host contains a control or format character once decoded, such as `ex%0Aample.com`.
    /// The value is the host as written.
    case invalidHost(String)
    /// A query item's name or value contains a control or format character once decoded. The
    /// value is the item's name as written.
    case invalidQueryItem(String)
    /// The `p` item of a default App Clip link is not a bundle identifier.
    case invalidBundleIdentifier(String)
}
