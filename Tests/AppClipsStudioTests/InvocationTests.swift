import Foundation
import Testing
@testable import AppClipsStudio

@Suite("Invocation")
struct InvocationTests {
    private func invocation(_ text: String, limits: InvocationLimits = .standard) throws -> Invocation {
        try Invocation(url: #require(URL(string: text)), limits: limits)
    }

    private func error(_ text: String, limits: InvocationLimits = .standard) -> InvocationError? {
        guard let url = URL(string: text) else { return nil }
        do {
            _ = try Invocation(url: url, limits: limits)
            return nil
        } catch {
            return error
        }
    }

    @Test func splitsPathAndQuery() throws {
        let value = try invocation("https://Example.COM/menu/lunch?p=12&size=large&p=13")
        #expect(value.host == "example.com")
        #expect(value.pathComponents == ["menu", "lunch"])
        #expect(value.queryValue("p") == "12")
        #expect(value.queryValues("p") == ["12", "13"])
        #expect(value.queryValue("missing") == nil)
        #expect(!value.isDefaultAppClipLink)
    }

    @Test func decodesPercentEncodingButKeepsEncodedSlashInOneComponent() throws {
        let value = try invocation("https://example.com/shop/caf%C3%A9/a%2Fb?name=Jo%26Al")
        #expect(value.pathComponents == ["shop", "café", "a/b"])
        #expect(value.queryValue("name") == "Jo&Al")
    }

    @Test func rootURLHasNoPathComponents() throws {
        #expect(try invocation("https://example.com").pathComponents.isEmpty)
        #expect(try invocation("https://example.com/").pathComponents.isEmpty)
        #expect(try invocation("https://example.com//menu//").pathComponents == ["menu"])
    }

    @Test func dropsTrailingDotFromHost() throws {
        #expect(try invocation("https://example.com./menu").host == "example.com")
    }

    @Test func recognizesDefaultAppClipLink() throws {
        let value = try invocation("https://appclip.apple.com/id?p=com.example.MyApp.Clip&table=4")
        #expect(value.isDefaultAppClipLink)
        #expect(value.defaultLinkBundleIdentifier == "com.example.MyApp.Clip")
        #expect(value.queryItems.map(\.name) == ["table"])
        #expect(value.queryValue("table") == "4")
    }

    @Test func otherAppleURLsAreNotDefaultLinks() throws {
        #expect(try !invocation("https://appclip.apple.com/other?p=x").isDefaultAppClipLink)
        #expect(try !invocation("https://example.com/id?p=x").isDefaultAppClipLink)
    }

    @Test func rejectsSchemesOtherThanHTTPS() {
        #expect(error("http://example.com/menu") == .unsupportedScheme("http"))
        #expect(error("myapp://menu") == .unsupportedScheme("myapp"))
        #expect(error("example.com/menu") == .unsupportedScheme(nil))
    }

    @Test func acceptsUppercaseScheme() throws {
        #expect(try invocation("HTTPS://example.com/menu").pathComponents == ["menu"])
    }

    @Test func rejectsURLWithoutHost() {
        #expect(error("https:///menu") == .missingHost)
    }

    @Test func rejectsDotSegmentsAndInvalidPercentEncoding() {
        #expect(error("https://example.com/menu/../admin") == .invalidPathComponent(".."))
        #expect(error("https://example.com/./menu") == .invalidPathComponent("."))
        #expect(error("https://example.com/%2E%2E/admin") == .invalidPathComponent("%2E%2E"))
    }

    @Test func rejectsControlAndFormatCharactersInThePath() {
        #expect(error("https://example.com/menu%0Aadmin") == .invalidPathComponent("menu%0Aadmin"))
        #expect(error("https://example.com/%00") == .invalidPathComponent("%00"))
        #expect(error("https://example.com/caf%E2%80%AEe") == .invalidPathComponent("caf%E2%80%AEe"))
    }

    @Test func enforcesURLLengthBeforeParsing() {
        let long = "https://example.com/" + String(repeating: "a", count: 3000)
        #expect(error(long) == .urlTooLong(length: long.utf8.count, limit: 2048))
        let limits = InvocationLimits(maximumURLLength: 20)
        #expect(error("https://example.com/menu", limits: limits) == .urlTooLong(length: 24, limit: 20))
    }

    @Test func enforcesPathAndQueryLimits() {
        let limits = InvocationLimits(maximumPathComponents: 2, maximumQueryItems: 2)
        #expect(error("https://example.com/a/b/c", limits: limits) == .tooManyPathComponents(count: 3, limit: 2))
        #expect(error("https://example.com/a?x=1&y=2&z=3", limits: limits) == .tooManyQueryItems(count: 3, limit: 2))
        let many = "https://example.com/?" + (0..<65).map { "k\($0)=1" }.joined(separator: "&")
        #expect(error(many) == .tooManyQueryItems(count: 65, limit: 64))
    }

    @Test func readsBrowsingWebActivities() throws {
        let activity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
        activity.webpageURL = URL(string: "https://example.com/order/7")
        #expect(try Invocation(userActivity: activity).pathComponents == ["order", "7"])
    }

    @Test func rejectsOtherActivitiesAndMissingURLs() {
        let other = NSUserActivity(activityType: "com.example.reading")
        #expect(throws: InvocationError.notBrowsingWeb(activityType: "com.example.reading")) {
            try Invocation(userActivity: other)
        }
        let empty = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
        #expect(throws: InvocationError.missingURL) {
            try Invocation(userActivity: empty)
        }
    }
}

@Suite("Last invocation store")
struct LastInvocationStoreTests {
    private let defaults: UserDefaults
    private let store: LastInvocationStore

    init() throws {
        let suite = "AppClipsStudioTests.\(UUID().uuidString)"
        defaults = try #require(UserDefaults(suiteName: suite))
        store = LastInvocationStore(defaults: defaults, key: "last")
    }

    @Test func savesAndRestoresTheLastInvocation() throws {
        #expect(store.load() == nil)
        let invocation = try Invocation(url: #require(URL(string: "https://example.com/table/4")))
        store.save(invocation)
        #expect(store.load()?.pathComponents == ["table", "4"])
        store.clear()
        #expect(store.load() == nil)
    }

    @Test func revalidatesWhatItLoads() {
        defaults.set("http://example.com/table/4", forKey: "last")
        #expect(store.load() == nil)
        defaults.set("https://example.com/" + String(repeating: "x", count: 5000), forKey: "last")
        #expect(store.load() == nil)
        defaults.set("not a url at all \u{0}", forKey: "last")
        #expect(store.load() == nil)
    }
}
