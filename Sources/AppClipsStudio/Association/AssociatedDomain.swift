import Foundation

/// One entry of the Associated Domains entitlement, such as `appclips:example.com` or
/// `applinks:*.example.com?mode=developer`.
///
/// Apple's format is `<service>:<fully qualified domain>`, optionally followed by
/// `?mode=<alternate mode>` while developing against a private server. For `appclips`, the
/// domain can't use a `*.` wildcard, and no entry may contain a path, a query other than `mode`
/// or a trailing slash.
public struct AssociatedDomain: Sendable, Hashable, CustomStringConvertible {
    /// The services that use associated domains.
    public enum Service: String, Sendable, Hashable, CaseIterable {
        case applinks
        case webcredentials
        case activitycontinuation
        case appclips
    }

    /// The alternate modes that bypass Apple's CDN during development.
    public enum Mode: String, Sendable, Hashable, CaseIterable {
        case developer
        case managed
        case developerAndManaged = "developer+managed"
    }

    /// The service.
    public let service: Service
    /// The domain without a wildcard prefix, in lowercase.
    public let domain: String
    /// Whether the entry starts with `*.` and covers every subdomain.
    public let includesSubdomains: Bool
    /// The alternate mode, if any.
    public let mode: Mode?

    /// The longest entry accepted.
    public static let maximumLength = 300

    /// Parses an entitlement entry, or throws the first rule it breaks.
    public init(_ entry: String) throws(AssociatedDomainError) {
        guard entry.utf8.count <= Self.maximumLength else { throw .tooLong(limit: Self.maximumLength) }
        guard let colon = entry.firstIndex(of: ":") else { throw .missingService }
        guard let service = Service(rawValue: String(entry[..<colon])) else {
            throw .unknownService(String(entry[..<colon]))
        }
        var rest = Substring(entry[entry.index(after: colon)...])
        var mode: Mode?
        if let question = rest.firstIndex(of: "?") {
            let query = rest[rest.index(after: question)...]
            guard query.hasPrefix("mode="), let parsed = Mode(rawValue: String(query.dropFirst(5))) else {
                throw .invalidMode(String(query))
            }
            mode = parsed
            rest = rest[..<question]
        }
        var includesSubdomains = false
        if rest.hasPrefix("*.") {
            guard service != .appclips else { throw .wildcardNotAllowedForAppClips }
            includesSubdomains = true
            rest = rest.dropFirst(2)
        }
        try Self.validate(domain: rest)
        self.service = service
        self.domain = rest.lowercased()
        self.includesSubdomains = includesSubdomains
        self.mode = mode
    }

    /// The entry in entitlement form.
    public var description: String {
        let wildcard = includesSubdomains ? "*." : ""
        let suffix = mode.map { "?mode=\($0.rawValue)" } ?? ""
        return "\(service.rawValue):\(wildcard)\(domain)\(suffix)"
    }

    /// The URL where Apple's CDN looks for this domain's association file.
    public var associationFileURL: URL? {
        URL(string: "https://\(domain)/.well-known/apple-app-site-association")
    }

    private static func validate(domain: Substring) throws(AssociatedDomainError) {
        guard !domain.isEmpty else { throw .missingDomain }
        if domain.contains("/") { throw .containsPath(String(domain)) }
        if domain.contains(":") { throw .containsPort(String(domain)) }
        let labels = domain.split(separator: ".", omittingEmptySubsequences: false)
        guard labels.count >= 2 else { throw .notFullyQualified(String(domain)) }
        for label in labels {
            let validLabel = !label.isEmpty && label.utf8.count <= 63
                && label.first != "-" && label.last != "-"
                && label.utf8.allSatisfy { byte in
                    (byte >= UInt8(ascii: "a") && byte <= UInt8(ascii: "z"))
                        || (byte >= UInt8(ascii: "A") && byte <= UInt8(ascii: "Z"))
                        || (byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9"))
                        || byte == UInt8(ascii: "-")
                }
            guard validLabel else { throw .invalidDomain(String(domain)) }
        }
    }
}

/// Why an associated domain entry was rejected.
public enum AssociatedDomainError: Error, Sendable, Hashable {
    /// The entry is longer than ``AssociatedDomain/maximumLength``.
    case tooLong(limit: Int)
    /// There is no `service:` prefix.
    case missingService
    /// The service is not `applinks`, `webcredentials`, `activitycontinuation` or `appclips`.
    case unknownService(String)
    /// The query is not `mode=developer`, `mode=managed` or `mode=developer+managed`.
    case invalidMode(String)
    /// `appclips` entries can't use a `*.` wildcard.
    case wildcardNotAllowedForAppClips
    /// Nothing follows the service.
    case missingDomain
    /// The domain contains a `/`: a path or a trailing slash.
    case containsPath(String)
    /// The domain contains a `:` port.
    case containsPort(String)
    /// The domain has no dot, such as `localhost`.
    case notFullyQualified(String)
    /// A label is empty, longer than 63 characters, starts or ends with `-`, or contains
    /// characters other than ASCII letters, digits and `-`.
    case invalidDomain(String)
}
