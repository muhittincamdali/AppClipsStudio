import Testing
@testable import AppClipsStudio

@Suite("App Clip Code URL check")
struct AppClipCodeURLCheckTests {
    private func kinds(_ url: String) -> [AppClipCodeFinding.Kind] {
        AppClipCodeURLCheck.findings(for: url).map(\.kind)
    }

    @Test(arguments: [
        "https://appclip.example.com/shop?p=123&p1=456&p2=789",
        "https://example.com",
        "https://example.com/menu",
        "https://appclip.example.com?p=1",
        "https://example.com/store-locator#top"
    ])
    func urlsThatFollowEveryRuleHaveNoFindings(url: String) {
        #expect(kinds(url).isEmpty)
    }

    @Test func requiresLowercaseHTTPS() {
        #expect(kinds("http://example.com") == [.schemeNotLowercaseHTTPS])
        #expect(kinds("HTTPS://example.com") == [.schemeNotLowercaseHTTPS])
        #expect(kinds("Https://example.com") == [.schemeNotLowercaseHTTPS])
        #expect(kinds("") == [.schemeNotLowercaseHTTPS])
    }

    @Test func hostAllowsOnlyLowercaseLettersDotsAndHyphens() {
        #expect(kinds("https://") == [.missingHost])
        #expect(kinds("https://Example.com") == [.invalidHostCharacter("E")])
        #expect(kinds("https://shop1.example.com") == [.invalidHostCharacter("1")])
        #expect(kinds("https://example.com:443/menu") == [.invalidHostCharacter(":")])
        #expect(kinds("https://user@example.com") == [.invalidHostCharacter("@")])
    }

    @Test func restAllowsOnlyTheDocumentedCharacters() {
        #expect(kinds("https://example.com/menu~1") == [.invalidCharacter("~")])
        #expect(kinds("https://example.com/a b") == [.invalidCharacter("U+0020")])
        #expect(kinds("https://example.com/caf\u{E9}") == [.invalidCharacter("U+00E9")])
        #expect(kinds("https://example.com/\u{1B}[31m") == [.invalidCharacter("U+001B")])
    }

    @Test func errorsAreReportedAsErrors() {
        let findings = AppClipCodeURLCheck.findings(for: "https://Example.com/a b")
        #expect(findings.map(\.severity) == [.error, .error])
        #expect(findings.allSatisfy { !$0.message.isEmpty })
    }

    @Test func rejectsOverlongInputWithoutScanningIt() {
        let url = "https://example.com/" + String(repeating: "a", count: 2000)
        #expect(kinds(url) == [.tooLong(limit: AppClipCodeURLCheck.maximumInputLength)])
    }

    @Test func suggestsEfficientHostNames() {
        #expect(kinds("https://www.example.com") == [.wwwSubdomain])
        #expect(kinds("https://shop.appclip.example.com") == [.appClipSubdomainNotFirst])
    }

    @Test func suggestsShortPaths() {
        #expect(kinds("https://example.com/") == [.trailingSlash])
        #expect(kinds("https://example.com/menu/") == [.trailingSlash])
        #expect(kinds("https://example.com/menu/lunch") == [.multiplePathComponents(2)])
        #expect(kinds("https://example.com/smoothies") == [.uncommonPathWord("smoothies")])
    }

    @Test func suggestsOrderedNumericQueries() {
        #expect(kinds("https://example.com/shop?a=1&b=2") == [.unorderedQueryNames])
        #expect(kinds("https://example.com/shop?p1=1&p=2") == [.unorderedQueryNames])
        #expect(kinds("https://example.com/shop?p=view") == [.nonDecimalQueryValue("view")])
        #expect(kinds("https://example.com/shop?p=3F2504E0-4F89-11D3-9A0C-0305E82C3301") == [.longIdentifier("3F2504E0-4F89-11D3-9A0C-0305E82C3301")])
        #expect(kinds("https://example.com/shop?p=3f2504e04f8911d39a0c0305e82c3301") == [.longIdentifier("3f2504e04f8911d39a0c0305e82c3301")])
    }

    @Test func suggestionsAreNotErrors() {
        let findings = AppClipCodeURLCheck.findings(for: "https://www.example.com/a/b/?x=y")
        #expect(!findings.isEmpty)
        #expect(findings.allSatisfy { $0.severity == .suggestion })
    }

    @Test func everyDocumentedPathWordIsKnown() {
        #expect(AppClipCodeURLCheck.efficientPathWords.count == 156)
        for word in ["about", "item_id", "store-locator", "wiki", "checkout", "product_id"] {
            #expect(AppClipCodeURLCheck.efficientPathWords.contains(word))
        }
    }
}
