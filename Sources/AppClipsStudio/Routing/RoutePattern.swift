import Foundation

/// A path pattern that an ``InvocationRouter`` matches invocations against.
///
/// Write patterns as paths, optionally preceded by a host:
///
/// - `/menu` matches exactly `/menu`.
/// - `/order/:id` matches `/order/42` and captures `id` = `"42"`.
/// - `/shop/*` matches `/shop` and anything below it; the rest of the path is
///   ``RouteMatch/remainder``.
/// - `appclip.example.com/table/:number` matches only that host.
///
/// Literal components are compared exactly (paths are case-sensitive); hosts are not.
public struct RoutePattern: Sendable, Hashable, CustomStringConvertible {
    enum Segment: Sendable, Hashable {
        case literal(String)
        case parameter(String)
    }

    /// The host this pattern is limited to, in lowercase and without a trailing dot, or `nil`
    /// for any allowed host.
    public let host: String?
    let segments: [Segment]
    let matchesDescendants: Bool

    /// The pattern as it was written.
    public let description: String

    /// Parses a pattern, or throws when it is not well formed.
    public init(_ pattern: String) throws(RoutePatternError) {
        guard !pattern.isEmpty else { throw .empty }
        let slash = pattern.firstIndex(of: "/") ?? pattern.endIndex
        let hostPart = pattern[..<slash].lowercased()
        guard hostPart.allSatisfy({ $0.isASCII && ($0.isLetter || $0.isNumber || $0 == "." || $0 == "-") }) else {
            throw .invalidHost(hostPart)
        }
        let host = Invocation.normalizedHost(hostPart)
        guard host.isEmpty == hostPart.isEmpty else { throw .invalidHost(hostPart) }
        var parts = pattern[slash...].split(separator: "/", omittingEmptySubsequences: true).map(String.init)

        var descendants = false
        if parts.last == "*" {
            descendants = true
            parts.removeLast()
        }
        var names = Set<String>()
        var segments: [Segment] = []
        for part in parts {
            segments.append(try Self.segment(part, names: &names))
        }

        self.host = host.isEmpty ? nil : host
        self.segments = segments
        self.matchesDescendants = descendants
        self.description = pattern
    }

    private static func segment(_ part: String, names: inout Set<String>) throws(RoutePatternError) -> Segment {
        guard part != "*" else { throw .wildcardNotLast }
        guard part.hasPrefix(":") else { return .literal(part) }
        let name = String(part.dropFirst())
        guard !name.isEmpty else { throw .unnamedParameter }
        guard names.insert(name).inserted else { throw .duplicateParameter(name) }
        return .parameter(name)
    }

    /// Matches the invocation's host and path, returning the captured parameters.
    func match(_ invocation: Invocation) -> (parameters: [String: String], remainder: [String])? {
        if let host, host != invocation.host { return nil }
        let path = invocation.pathComponents
        guard path.count == segments.count || (matchesDescendants && path.count >= segments.count) else {
            return nil
        }
        var parameters: [String: String] = [:]
        for (segment, component) in zip(segments, path) {
            switch segment {
            case .literal(let literal):
                guard literal == component else { return nil }
            case .parameter(let name):
                parameters[name] = component
            }
        }
        return (parameters, Array(path.dropFirst(segments.count)))
    }

    /// Orders patterns from most to least specific: a longer prefix first, then more literal
    /// components, then exact patterns before `/*` patterns, then patterns with a host.
    func isMoreSpecific(than other: RoutePattern) -> Bool {
        if segments.count != other.segments.count { return segments.count > other.segments.count }
        if literalCount != other.literalCount { return literalCount > other.literalCount }
        if matchesDescendants != other.matchesDescendants { return !matchesDescendants }
        return host != nil && other.host == nil
    }

    private var literalCount: Int {
        segments.reduce(0) { count, segment in
            if case .literal = segment { return count + 1 }
            return count
        }
    }
}

/// Why a route pattern could not be parsed.
public enum RoutePatternError: Error, Sendable, Hashable {
    /// The pattern is an empty string.
    case empty
    /// A `:` component has no name.
    case unnamedParameter
    /// Two parameters share a name.
    case duplicateParameter(String)
    /// `*` appears anywhere other than as the last component.
    case wildcardNotLast
    /// The host part contains characters other than ASCII letters, digits, `.` and `-`.
    case invalidHost(String)
}
