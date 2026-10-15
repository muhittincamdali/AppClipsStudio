import Foundation
import Testing
@testable import AppClipsStudio

@Suite("Handoff store")
struct HandoffStoreTests {
    struct Cart: Codable, Sendable, Equatable {
        var items: [String]
        var total: Double = 0
    }

    /// A clock the tests move by hand.
    final class Clock: @unchecked Sendable {
        var now = Date(timeIntervalSinceReferenceDate: 800_000_000)
    }

    private let defaults: UserDefaults
    private let clock = Clock()

    init() throws {
        defaults = try #require(UserDefaults(suiteName: "AppClipsStudioTests.\(UUID().uuidString)"))
    }

    private func store(version: Int = 1, maximumBytes: Int = 64 * 1024) -> HandoffStore<Cart> {
        let clock = clock
        return HandoffStore(defaults: defaults, key: "cart", schemaVersion: version, maximumBytes: maximumBytes) { clock.now }
    }

    @Test func savesAndLoadsAValue() throws {
        let store = store()
        #expect(try store.load() == nil)
        try store.save(Cart(items: ["Latte", "Croissant"], total: 7.5))
        #expect(try store.load() == Cart(items: ["Latte", "Croissant"], total: 7.5))
        #expect(try store.load() != nil, "load keeps the value")
    }

    @Test func takeRemovesTheValue() throws {
        let store = store()
        try store.save(Cart(items: ["Tea"]))
        #expect(try store.take() == Cart(items: ["Tea"]))
        #expect(try store.take() == nil)
    }

    @Test func expiredValuesAreDiscarded() throws {
        let store = store()
        try store.save(Cart(items: ["Tea"]), expiresAfter: 60)
        clock.now += 59
        #expect(try store.load() == Cart(items: ["Tea"]))
        clock.now += 1
        #expect(try store.load() == nil)
        #expect(defaults.data(forKey: "cart") == nil, "an expired value is removed")
    }

    @Test(arguments: [0, -1, .nan, .infinity, -.infinity, .signalingNaN] as [Double])
    func rejectsInvalidExpiry(interval: Double) throws {
        let store = store()
        #expect(throws: HandoffError.invalidExpiry) {
            try store.save(Cart(items: ["Tea"]), expiresAfter: interval)
        }
        #expect(try store.load() == nil)
    }

    @Test func rejectsValuesThatCannotBeEncoded() {
        #expect(throws: HandoffError.self) {
            try store().save(Cart(items: [], total: .nan))
        }
    }

    @Test func rejectsValuesLargerThanTheLimit() throws {
        let store = store(maximumBytes: 200)
        let big = Cart(items: Array(repeating: "Espresso", count: 50))
        #expect {
            try store.save(big)
        } throws: { error in
            guard case HandoffError.tooLarge(let bytes, 200) = error else { return false }
            return bytes > 200
        }
        #expect(try store.load() == nil)
    }

    @Test func oversizedStoredDataIsNotDecodedAndIsRemoved() throws {
        defaults.set(Data(repeating: 0x7B, count: 70_000), forKey: "cart")
        #expect(throws: HandoffError.tooLarge(bytes: 70_000, limit: 64 * 1024)) {
            try store().load()
        }
        #expect(defaults.data(forKey: "cart") == nil)
    }

    @Test func otherSchemaVersionsAreNotDecoded() throws {
        try store(version: 1).save(Cart(items: ["Tea"]))
        #expect(throws: HandoffError.schemaMismatch(stored: 1, expected: 2)) {
            try store(version: 2).load()
        }
        #expect(try store(version: 1).load() == Cart(items: ["Tea"]), "the value stays for the version that wrote it")
    }

    @Test func foreignDataFailsToDecode() {
        defaults.set(Data("not json".utf8), forKey: "cart")
        #expect(throws: HandoffError.self) { try store().load() }
        defaults.set(Data(#"{"version":1,"savedAt":0,"value":{"items":"oops"}}"#.utf8), forKey: "cart")
        #expect(throws: HandoffError.self) { try store().load() }
    }

    @Test func appGroupInitializerUsesTheSuite() throws {
        let suite = "AppClipsStudioTests.\(UUID().uuidString)"
        let store = try #require(HandoffStore<Cart>(appGroup: suite, key: "cart"))
        try store.save(Cart(items: ["Mocha"]))
        #expect(UserDefaults(suiteName: suite)?.data(forKey: "cart") != nil)
    }
}
