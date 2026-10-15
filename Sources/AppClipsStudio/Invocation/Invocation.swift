import Foundation

/// A validated App Clip invocation URL, split into the parts an App Clip routes on.
///
/// The system passes the invocation URL to the App Clip (and to the full app once it replaces
/// the App Clip) in an `NSUserActivity` of type `NSUserActivityTypeBrowsingWeb`. `Invocation`
/// checks that URL before any of it reaches your code: it must use `https`, have a host, stay
/// within ``InvocationLimits`` and contain no `.` or `..` path components. Path components and
/// query values are percent-decoded; an encoded slash (`%2F`) stays inside its component.
///
/// The default App Clip link that App Store Connect generates,
/// `https://appclip.apple.com/id?p=<bundle ID>&key=value`, is recognized: its `p` item is
/// reported as ``defaultLinkBundleIdentifier`` and left out of ``queryItems``.
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

        let path = try Self.decodedPath(components.percentEncodedPath, limits: limits)
        var items = components.queryItems ?? []
        guard items.count <= limits.maximumQueryItems else {
            throw .tooManyQueryItems(count: items.count, limit: limits.maximumQueryItems)
        }

        var bundleIdentifier: String?
        if host == Self.defaultLinkHost, path == ["id"],
           let index = items.firstIndex(where: { $0.name == "p" }) {
            bundleIdentifier = items[index].value
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

    private static func normalizedHost(_ host: String?) -> String {
        var host = (host ?? "").lowercased()
        if host.hasSuffix(".") {
            host.removeLast()
        }
        return host
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
                  !value.isEmpty, value != ".", value != ".." else {
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
    /// A path component is `.`, `..`, or not valid percent-encoding.
    case invalidPathComponent(String)
}
