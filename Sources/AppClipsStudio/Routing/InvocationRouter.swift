import Foundation

/// Maps invocation URLs to your own destination type, the way App Store Connect maps them to
/// App Clip experiences: the route with the most specific matching prefix wins.
///
/// ```swift
/// enum Screen { case menu, order(Int), table(String) }
///
/// var router = InvocationRouter<Screen>(allowedHosts: ["example.com", "appclip.example.com"])
/// try router.add("/menu") { _ in .menu }
/// try router.add("/order/:id") { match in match.integer("id").map(Screen.order) }
/// try router.add("appclip.example.com/table/:number") { match in .table(match["number"]!) }
/// router.fallback { _ in .menu }
///
/// let screen = try router.route(url)
/// ```
///
/// A handler can return `nil` to decline a match (for example, when `id` is not a number); the
/// router then tries the next most specific route, and finally the fallback. Apple requires the
/// App Clip and the full app to handle every URL under a registered prefix, so register a
/// fallback for anything the routes do not cover.
public struct InvocationRouter<Destination>: Sendable {
    /// Turns a match into a destination, or returns `nil` to let the next route try.
    public typealias Handler = @Sendable (RouteMatch) -> Destination?

    private struct Route: Sendable {
        let pattern: RoutePattern
        let order: Int
        let handler: Handler
    }

    /// The hosts invocations may come from, in lowercase and without a trailing dot, as
    /// ``Invocation/host`` is. Empty allows any host.
    public let allowedHosts: Set<String>
    /// The bounds every invocation URL must stay within.
    public let limits: InvocationLimits
    private var routes: [Route] = []
    private var fallbackHandler: Handler?

    /// Creates a router.
    ///
    /// - Parameters:
    ///   - allowedHosts: The hosts your App Clip experiences use. Invocations from other hosts
    ///     throw ``InvocationError/hostNotAllowed(_:)``. Include `appclip.apple.com` to accept
    ///     default App Clip links.
    ///   - limits: The bounds every invocation URL must stay within.
    public init(allowedHosts: Set<String> = [], limits: InvocationLimits = .standard) {
        self.allowedHosts = Set(allowedHosts.map { Invocation.normalizedHost($0) })
        self.limits = limits
    }

    /// Adds a route for a pattern such as `/order/:id`; see ``RoutePattern`` for the syntax.
    public mutating func add(_ pattern: String, handler: @escaping Handler) throws(RoutePatternError) {
        let parsed = try RoutePattern(pattern)
        let route = Route(pattern: parsed, order: routes.count, handler: handler)
        let index = routes.firstIndex { Self.precedes(route, $0) } ?? routes.endIndex
        routes.insert(route, at: index)
    }

    /// Sets the handler for invocations that no route accepts.
    public mutating func fallback(_ handler: @escaping Handler) {
        fallbackHandler = handler
    }

    /// The patterns in the order the router tries them.
    public var patterns: [RoutePattern] {
        routes.map(\.pattern)
    }

    /// Validates a URL and returns the destination for it, or `nil` when nothing accepts it.
    public func route(_ url: URL) throws(InvocationError) -> Destination? {
        try route(Invocation(url: url, limits: limits))
    }

    /// Validates a user activity's URL and returns the destination for it.
    public func route(_ activity: NSUserActivity) throws(InvocationError) -> Destination? {
        try route(Invocation(userActivity: activity, limits: limits))
    }

    /// Returns the destination for an invocation, or `nil` when nothing accepts it.
    public func route(_ invocation: Invocation) throws(InvocationError) -> Destination? {
        guard allowedHosts.isEmpty || allowedHosts.contains(invocation.host) else {
            throw .hostNotAllowed(invocation.host)
        }
        for route in routes {
            guard let (parameters, remainder) = route.pattern.match(invocation) else { continue }
            let match = RouteMatch(invocation: invocation, pattern: route.pattern, parameters: parameters, remainder: remainder)
            if let destination = route.handler(match) {
                return destination
            }
        }
        guard let fallbackHandler else { return nil }
        let match = RouteMatch(invocation: invocation, pattern: nil, parameters: [:], remainder: invocation.pathComponents)
        return fallbackHandler(match)
    }

    private static func precedes(_ route: Route, _ other: Route) -> Bool {
        if route.pattern.isMoreSpecific(than: other.pattern) { return true }
        if other.pattern.isMoreSpecific(than: route.pattern) { return false }
        return route.order < other.order
    }
}

/// The result of matching an invocation against a route.
public struct RouteMatch: Sendable, Hashable {
    /// The validated invocation.
    public let invocation: Invocation
    /// The pattern that matched, or `nil` for the fallback.
    public let pattern: RoutePattern?
    /// The values captured by `:name` components.
    public let parameters: [String: String]
    /// The path components below a `/*` pattern; the whole path for the fallback.
    public let remainder: [String]

    /// The value captured for a `:name` component.
    public subscript(parameter: String) -> String? {
        parameters[parameter]
    }

    /// The captured value as an integer, or `nil` when it is missing or not a whole number
    /// that fits in `Int`.
    public func integer(_ parameter: String) -> Int? {
        parameters[parameter].flatMap(Self.integer(from:))
    }

    /// The value of the first query item with this name.
    public func query(_ name: String) -> String? {
        invocation.queryValue(name)
    }

    /// The first query item with this name as an integer, or `nil` when it is missing or not a
    /// whole number that fits in `Int`.
    public func queryInteger(_ name: String) -> Int? {
        invocation.queryValue(name).flatMap(Self.integer(from:))
    }

    /// Accepts an optional `-` followed by ASCII digits only, so `"+5"`, `" 5"` and non-ASCII
    /// digits are rejected; out-of-range values give `nil` instead of trapping.
    static func integer(from text: String) -> Int? {
        let digits = text.hasPrefix("-") ? text.dropFirst() : Substring(text)
        guard !digits.isEmpty, digits.utf8.allSatisfy({ $0 >= UInt8(ascii: "0") && $0 <= UInt8(ascii: "9") }) else {
            return nil
        }
        return Int(text)
    }
}
