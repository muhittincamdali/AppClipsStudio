import Foundation

/// Checks a URL against Apple's rules for URLs encoded in an App Clip Code.
///
/// An App Clip Code holds a compressed URL with limited capacity. Apple documents which URLs are
/// valid at all (``AppClipCodeFinding/Severity/error``) and which practices make a URL more
/// likely to fit (``AppClipCodeFinding/Severity/suggestion``). Whether a valid URL finally fits
/// depends on Apple's encoder, so a URL without errors can still be too long; Apple's App Clip
/// Code Generator and App Store Connect report that.
///
/// ```swift
/// let findings = AppClipCodeURLCheck.findings(for: "https://www.example.com/products/")
/// // suggestion: wwwSubdomain, suggestion: trailingSlash
/// ```
public enum AppClipCodeURLCheck {
    /// The longest input checked, in UTF-8 bytes; longer input gives a single
    /// ``AppClipCodeFinding/Kind/tooLong`` error without being scanned.
    public static let maximumInputLength = 1024

    /// Path words that Apple's encoder compresses well when used as the single path component.
    public static let efficientPathWords: Set<String> = Set("""
        about access account add app archives article attraction author bag biz book brand brands \
        browse buy cancel cart cat catalog category categories channel charts checkin checkout \
        collection collections company compare connect contact content contents cost coupons create \
        data demo destinations detail discover download entry event events explore faq fetch finance \
        find food fund game gift goods guide health help home hotel hotels id index info item item_id \
        join lifestyle list listen live local location locations locator login manage menu more music \
        name news note open order overview park part pay payment payments play post posts preview \
        product product_id products profile promotion purchase rate recipe recipes reservation \
        reservations reserve retail review rewards sale scan schedule search sell send service share \
        shop show showtime site song special stations status store store-locator stores stories story \
        tag tags terms tickets tips title today top topic tours track transaction travel try update \
        upload use user vehicles video view visit watch wiki
        """.split(separator: " ").map(String.init))

    private static let hostCharacters = Set("abcdefghijklmnopqrstuvwxyz.-")
    private static let restCharacters = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/#?=%-._,+;:&")

    /// Returns every rule the URL breaks, errors first.
    public static func findings(for url: String) -> [AppClipCodeFinding] {
        guard url.utf8.count <= maximumInputLength else {
            return [AppClipCodeFinding(.tooLong(limit: maximumInputLength))]
        }
        let scheme = "https://"
        guard url.hasPrefix(scheme) else {
            return [AppClipCodeFinding(.schemeNotLowercaseHTTPS)]
        }
        let afterScheme = url.dropFirst(scheme.count)
        let hostEnd = afterScheme.firstIndex { "/?#".contains($0) } ?? afterScheme.endIndex
        let host = String(afterScheme[..<hostEnd])
        let rest = String(afterScheme[hostEnd...])

        var findings = hostFindings(host)
        if let invalid = rest.first(where: { !restCharacters.contains($0) }) {
            findings.append(AppClipCodeFinding(.invalidCharacter(describe(invalid))))
        }
        guard findings.isEmpty else { return findings }
        return URLParts(rest).suggestions()
    }

    /// Printable ASCII as is; anything else as `U+XXXX`, so control characters never reach a
    /// terminal.
    static func describe(_ character: Character) -> String {
        if character.isASCII, let scalar = character.unicodeScalars.first, scalar.value >= 0x21, scalar.value < 0x7F {
            return String(character)
        }
        return character.unicodeScalars.map { "U+" + String($0.value, radix: 16, uppercase: true).leftPadded(to: 4) }.joined(separator: " ")
    }

    private static func hostFindings(_ host: String) -> [AppClipCodeFinding] {
        guard !host.isEmpty else { return [AppClipCodeFinding(.missingHost)] }
        if let invalid = host.first(where: { !hostCharacters.contains($0) }) {
            return [AppClipCodeFinding(.invalidHostCharacter(describe(invalid)))]
        }
        var findings: [AppClipCodeFinding] = []
        let labels = host.split(separator: ".", omittingEmptySubsequences: false)
        if labels.first == "www" {
            findings.append(AppClipCodeFinding(.wwwSubdomain))
        }
        if labels.dropFirst().contains("appclip") {
            findings.append(AppClipCodeFinding(.appClipSubdomainNotFirst))
        }
        return findings
    }
}

/// The path, query and fragment of a URL whose characters already passed the checks.
private struct URLParts {
    let path: String
    let query: String?

    init(_ rest: String) {
        let withoutFragment = rest.split(separator: "#", maxSplits: 1, omittingEmptySubsequences: false).first.map(String.init) ?? ""
        let parts = withoutFragment.split(separator: "?", maxSplits: 1, omittingEmptySubsequences: false)
        path = parts.first.map(String.init) ?? ""
        query = parts.count > 1 ? String(parts[1]) : nil
    }

    func suggestions() -> [AppClipCodeFinding] {
        var findings: [AppClipCodeFinding] = []
        let components = path.split(separator: "/").map(String.init)
        if path.hasSuffix("/") {
            findings.append(AppClipCodeFinding(.trailingSlash))
        }
        if components.count > 1 {
            findings.append(AppClipCodeFinding(.multiplePathComponents(components.count)))
        } else if let word = components.first, !AppClipCodeURLCheck.efficientPathWords.contains(word) {
            findings.append(AppClipCodeFinding(.uncommonPathWord(word)))
        }
        findings += queryFindings()
        return findings
    }

    private func queryFindings() -> [AppClipCodeFinding] {
        guard let query, !query.isEmpty else { return [] }
        var findings: [AppClipCodeFinding] = []
        let items = query.split(separator: "&").map { $0.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false) }
        let names = items.compactMap { $0.first.map(String.init) }
        let ordered = names.indices.map { $0 == 0 ? "p" : "p\($0)" }
        if names != ordered {
            findings.append(AppClipCodeFinding(.unorderedQueryNames))
        }
        for value in items.compactMap({ $0.count > 1 ? String($0[1]) : nil }) {
            if Self.looksLikeUUID(value) {
                findings.append(AppClipCodeFinding(.longIdentifier(value)))
            } else if !value.isEmpty, !value.allSatisfy({ $0.isASCII && $0.isNumber }) {
                findings.append(AppClipCodeFinding(.nonDecimalQueryValue(value)))
            }
        }
        return findings
    }

    /// A UUID with or without dashes: 32 hexadecimal digits.
    private static func looksLikeUUID(_ value: String) -> Bool {
        let hex = value.filter { $0 != "-" }
        return hex.count == 32 && hex.allSatisfy(\.isHexDigit)
    }
}

/// One rule an App Clip Code URL breaks.
public struct AppClipCodeFinding: Sendable, Hashable, Encodable {
    /// Whether the URL can't be encoded at all or only encodes less efficiently.
    public enum Severity: String, Sendable, Hashable, Encodable {
        /// Apple's rules reject the URL.
        case error
        /// The URL is valid but uses more of the code's capacity than necessary.
        case suggestion
    }

    /// The rule.
    public enum Kind: Sendable, Hashable {
        /// The input is longer than ``AppClipCodeURLCheck/maximumInputLength``.
        case tooLong(limit: Int)
        /// The URL doesn't start with `https://` in lowercase.
        case schemeNotLowercaseHTTPS
        /// The URL has no host.
        case missingHost
        /// The host contains a character other than `a`–`z`, `.` and `-`.
        case invalidHostCharacter(String)
        /// The path, query or fragment contains a character Apple doesn't allow.
        case invalidCharacter(String)
        /// The host starts with `www.`.
        case wwwSubdomain
        /// `appclip` is a subdomain but not the first one.
        case appClipSubdomainNotFirst
        /// The path ends with `/`.
        case trailingSlash
        /// The path has more than one component.
        case multiplePathComponents(Int)
        /// The single path component is not one of ``AppClipCodeURLCheck/efficientPathWords``.
        case uncommonPathWord(String)
        /// Query names are not `p`, `p1`, `p2`, … in order.
        case unorderedQueryNames
        /// A query value looks like a UUID.
        case longIdentifier(String)
        /// A query value is not a decimal number.
        case nonDecimalQueryValue(String)
    }

    /// The rule.
    public let kind: Kind

    init(_ kind: Kind) {
        self.kind = kind
    }

    /// Whether the rule is an error or a suggestion.
    public var severity: Severity {
        switch kind {
        case .tooLong, .schemeNotLowercaseHTTPS, .missingHost, .invalidHostCharacter, .invalidCharacter:
            .error
        default:
            .suggestion
        }
    }

    /// A sentence that explains the rule.
    public var message: String {
        AppClipCodeMessages.message(for: kind)
    }

    private enum CodingKeys: String, CodingKey { case severity, message }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(severity, forKey: .severity)
        try container.encode(message, forKey: .message)
    }
}

private extension String {
    func leftPadded(to length: Int) -> String {
        count >= length ? self : String(repeating: "0", count: length - count) + self
    }
}
