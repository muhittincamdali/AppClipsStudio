import Foundation
import Testing
@testable import AppClipsStudio

@Suite("Invocation router")
struct RouterTests {
    enum Screen: Equatable {
        case home, menu, menuSection(String), order(Int), table(String), shop([String]), other(String)
    }

    private func url(_ text: String) throws -> URL {
        try #require(URL(string: text))
    }

    private func coffeeRouter() throws -> InvocationRouter<Screen> {
        var router = InvocationRouter<Screen>(allowedHosts: ["example.com", "AppClip.Example.com"])
        try router.add("/menu") { _ in .menu }
        try router.add("/menu/:section") { match in match["section"].map(Screen.menuSection) }
        try router.add("/order/:id") { match in match.integer("id").map(Screen.order) }
        try router.add("/shop/*") { match in .shop(match.remainder) }
        try router.add("appclip.example.com/table/:number") { match in match["number"].map(Screen.table) }
        router.fallback { _ in .home }
        return router
    }

    @Test func routesExactAndParameterPatterns() throws {
        let router = try coffeeRouter()
        #expect(try router.route(url("https://example.com/menu")) == .menu)
        #expect(try router.route(url("https://example.com/menu/breakfast")) == .menuSection("breakfast"))
        #expect(try router.route(url("https://example.com/order/42")) == .order(42))
        #expect(try router.route(url("https://appclip.example.com/table/7")) == .table("7"))
    }

    @Test func wildcardCapturesTheRestOfThePath() throws {
        let router = try coffeeRouter()
        #expect(try router.route(url("https://example.com/shop")) == .shop([]))
        #expect(try router.route(url("https://example.com/shop/mugs/blue")) == .shop(["mugs", "blue"]))
    }

    @Test func unmatchedURLsOnAnAllowedHostGoToTheFallback() throws {
        let router = try coffeeRouter()
        #expect(try router.route(url("https://example.com")) == .home)
        #expect(try router.route(url("https://example.com/contact")) == .home)
        // A host-specific route doesn't match other hosts.
        #expect(try router.route(url("https://example.com/table/7")) == .home)
    }

    @Test func handlerReturningNilFallsThroughToTheNextRoute() throws {
        let router = try coffeeRouter()
        #expect(try router.route(url("https://example.com/order/latte")) == .home)
        #expect(try router.route(url("https://example.com/order/99999999999999999999999")) == .home)
    }

    @Test func withoutFallbackUnmatchedURLsGiveNil() throws {
        var router = InvocationRouter<Screen>()
        try router.add("/menu") { _ in .menu }
        #expect(try router.route(url("https://anything.example/menu")) == .menu)
        #expect(try router.route(url("https://anything.example/other")) == nil)
    }

    @Test func rejectsHostsThatAreNotAllowed() throws {
        let router = try coffeeRouter()
        #expect(throws: InvocationError.hostNotAllowed("evil.example")) {
            try router.route(url("https://evil.example/menu"))
        }
        #expect(throws: InvocationError.unsupportedScheme("http")) {
            try router.route(url("http://example.com/menu"))
        }
    }

    @Test func mostSpecificPrefixWinsRegardlessOfRegistrationOrder() throws {
        var router = InvocationRouter<Screen>()
        try router.add("/*") { match in .other("any:" + match.remainder.joined(separator: "/")) }
        try router.add("/menu/*") { _ in .other("menu-any") }
        try router.add("/menu/:section") { _ in .other("menu-param") }
        try router.add("/menu/today") { _ in .other("menu-today") }
        try router.add("example.com/menu/today") { _ in .other("host-menu-today") }
        #expect(router.patterns.map(\.description) == ["example.com/menu/today", "/menu/today", "/menu/:section", "/menu/*", "/*"])
        #expect(try router.route(url("https://example.com/menu/today")) == .other("host-menu-today"))
        #expect(try router.route(url("https://other.example/menu/today")) == .other("menu-today"))
        #expect(try router.route(url("https://other.example/menu/dinner")) == .other("menu-param"))
        #expect(try router.route(url("https://other.example/menu/a/b")) == .other("menu-any"))
        #expect(try router.route(url("https://other.example/x/y")) == .other("any:x/y"))
    }

    @Test func equallySpecificRoutesKeepRegistrationOrder() throws {
        var router = InvocationRouter<Screen>()
        try router.add("/item/:id") { _ in .other("first") }
        try router.add("/item/:code") { _ in .other("second") }
        #expect(try router.route(url("https://example.com/item/1")) == .other("first"))
    }

    @Test func matchExposesQueryValues() throws {
        var router = InvocationRouter<Int>()
        try router.add("/order") { match in match.queryInteger("p") }
        #expect(try router.route(url("https://example.com/order?p=12")) == 12)
        #expect(try router.route(url("https://example.com/order?p=12x")) == nil)
    }

    @Test func hostsWithATrailingDotMatchAsInvocationHostsDo() throws {
        var router = InvocationRouter<Screen>(allowedHosts: ["Example.com."])
        #expect(router.allowedHosts == ["example.com"])
        try router.add("AppClip.Example.com./table/:number") { match in match["number"].map(Screen.table) }
        router.fallback { _ in .home }
        #expect(router.patterns.first?.host == "appclip.example.com")
        #expect(try router.route(url("https://example.com/menu")) == .home)
        #expect(try router.route(url("https://example.com./menu")) == .home)
        var hosted = InvocationRouter<Screen>()
        try hosted.add("appclip.example.com./table/:number") { match in match["number"].map(Screen.table) }
        #expect(try hosted.route(url("https://appclip.example.com/table/4")) == .table("4"))
        #expect(throws: RoutePatternError.invalidHost(".")) { try hosted.add("./a") { _ in .home } }
    }

    @Test func rejectsMalformedPatterns() {
        var router = InvocationRouter<Screen>()
        #expect(throws: RoutePatternError.empty) { try router.add("") { _ in .home } }
        #expect(throws: RoutePatternError.unnamedParameter) { try router.add("/order/:") { _ in .home } }
        #expect(throws: RoutePatternError.duplicateParameter("id")) { try router.add("/a/:id/b/:id") { _ in .home } }
        #expect(throws: RoutePatternError.wildcardNotLast) { try router.add("/a/*/b") { _ in .home } }
        #expect(throws: RoutePatternError.invalidHost("exa mple.com")) { try router.add("exa mple.com/a") { _ in .home } }
        #expect(router.patterns.isEmpty)
    }

    @Test(arguments: [
        ("42", 42), ("-7", -7), ("0", 0), ("007", 7),
        ("+5", nil), (" 5", nil), ("5 ", nil), ("", nil), ("-", nil), ("٣", nil), ("1e3", nil),
        ("9223372036854775807", Int.max), ("9223372036854775808", nil), ("-9223372036854775809", nil)
    ] as [(String, Int?)])
    func integerParsingNeverTraps(text: String, expected: Int?) {
        #expect(RouteMatch.integer(from: text) == expected)
    }
}
