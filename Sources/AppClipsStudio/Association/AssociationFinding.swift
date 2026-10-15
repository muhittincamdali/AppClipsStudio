import Foundation

/// One problem in an `apple-app-site-association` file.
public struct AssociationFinding: Sendable, Hashable, Encodable {
    /// Whether the problem blocks verification.
    public enum Severity: String, Sendable, Hashable, Encodable {
        /// The system or App Store Connect can't verify the App Clip with this file.
        case error
        /// The file works but probably not as intended.
        case warning
    }

    /// The problem.
    public enum Kind: Sendable, Hashable {
        /// The file is larger than the validator's limit.
        case tooLarge(bytes: Int, limit: Int)
        /// The file is not valid JSON.
        case invalidJSON
        /// The top level is not a JSON object.
        case notAnObject
        /// There is no `appclips` key.
        case missingAppClips
        /// `appclips.apps` is an empty array.
        case emptyAppClips
        /// A service doesn't have the documented shape.
        case malformedService(String)
        /// A value is not `TEAMID.bundle.identifier`.
        case invalidAppID(service: String, value: String)
        /// The App Clip you expected isn't in `appclips.apps`.
        case appClipNotListed(String)
        /// The App Clip's full app isn't in `applinks`, so it can't open the App Clip's URLs once
        /// it replaces the App Clip.
        case fullAppNotInAppLinks(appClip: String, app: String)
        /// A top-level key that Apple doesn't document.
        case unknownService(String)
    }

    /// The problem.
    public let kind: Kind

    init(_ kind: Kind) {
        self.kind = kind
    }

    /// Whether the problem blocks verification.
    public var severity: Severity {
        switch kind {
        case .fullAppNotInAppLinks, .unknownService: .warning
        default: .error
        }
    }

    /// A sentence that explains the problem.
    public var message: String {
        switch kind {
        case .tooLarge(let bytes, let limit):
            "The file is \(bytes) bytes; this check reads at most \(limit)."
        case .invalidJSON:
            "The file is not valid JSON."
        case .notAnObject:
            "The top level must be a JSON object."
        case .missingAppClips:
            "There is no \"appclips\" service, so the system can't verify the App Clip."
        case .emptyAppClips:
            "\"appclips.apps\" is empty."
        case .malformedService(let service):
            "\"\(service)\" doesn't have the documented shape."
        case .invalidAppID(let service, let value):
            "\"\(value)\" in \"\(service)\" is not a Team ID followed by a bundle identifier."
        case .appClipNotListed(let identifier):
            "\(identifier) is not listed in \"appclips.apps\"."
        case .fullAppNotInAppLinks(let appClip, let app):
            "\(app) is not in \"applinks\", so once it replaces \(appClip) it can't open the same URLs as universal links."
        case .unknownService(let key):
            "\"\(key)\" is not a service Apple documents."
        }
    }

    /// The text with control and non-ASCII characters replaced by `?` and cut to 80 characters,
    /// so file contents can be shown in a terminal safely.
    static func printable(_ text: String) -> String {
        let cleaned = String(text.prefix(80).map { character in
            character.isASCII && !character.isNewline && (character.asciiValue ?? 0) >= 0x20 && character != "\u{7F}" ? character : "?"
        })
        return text.count > 80 ? cleaned + "…" : cleaned
    }

    private enum CodingKeys: String, CodingKey { case severity, message }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(severity, forKey: .severity)
        try container.encode(message, forKey: .message)
    }
}
