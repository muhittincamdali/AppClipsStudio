import Foundation

/// An application identifier: a 10-character Team ID, a dot and a bundle identifier, as in
/// `ABCDE12345.com.example.MyApp.Clip`.
public struct AppIdentifier: Sendable, Hashable, CustomStringConvertible {
    /// The Team ID (application identifier prefix).
    public let teamID: String
    /// The bundle identifier.
    public let bundleIdentifier: String

    /// The longest bundle identifier accepted.
    public static let maximumBundleIdentifierLength = 255

    /// Parses `TEAMID.bundle.identifier`, or throws when either part is not well formed.
    public init(_ text: String) throws(AppIdentifierError) {
        guard let dot = text.firstIndex(of: ".") else { throw .missingTeamID(text) }
        try self.init(teamID: String(text[..<dot]), bundleIdentifier: String(text[text.index(after: dot)...]))
    }

    /// Creates an identifier from its parts, or throws when either is not well formed.
    public init(teamID: String, bundleIdentifier: String) throws(AppIdentifierError) {
        guard teamID.utf8.count == 10, teamID.utf8.allSatisfy(Self.isTeamIDByte) else {
            throw .invalidTeamID(teamID)
        }
        guard Self.isValidBundleIdentifier(bundleIdentifier) else {
            throw .invalidBundleIdentifier(bundleIdentifier)
        }
        self.teamID = teamID
        self.bundleIdentifier = bundleIdentifier
    }

    /// `TEAMID.bundle.identifier`.
    public var description: String {
        "\(teamID).\(bundleIdentifier)"
    }

    /// Whether this App Clip identifier belongs to `app`: same Team ID, and the App Clip's bundle
    /// identifier is the app's followed by a dot and more, like `com.example.MyApp.Clip` for
    /// `com.example.MyApp`.
    public func isAppClip(of app: AppIdentifier) -> Bool {
        teamID == app.teamID && bundleIdentifier.hasPrefix(app.bundleIdentifier + ".")
    }

    /// The identifier with its last bundle component removed, which is the parent app's
    /// identifier for an App Clip that follows Xcode's naming; `nil` without a dot.
    public var parentCandidate: AppIdentifier? {
        guard let dot = bundleIdentifier.lastIndex(of: ".") else { return nil }
        return try? AppIdentifier(teamID: teamID, bundleIdentifier: String(bundleIdentifier[..<dot]))
    }

    /// Letters, digits, `-` and `.`, not starting or ending with a dot and without empty parts.
    static func isValidBundleIdentifier(_ text: String) -> Bool {
        guard !text.isEmpty, text.utf8.count <= maximumBundleIdentifierLength else { return false }
        let parts = text.split(separator: ".", omittingEmptySubsequences: false)
        return parts.allSatisfy { part in
            !part.isEmpty && part.utf8.allSatisfy { byte in
                isTeamIDByte(byte) || (byte >= UInt8(ascii: "a") && byte <= UInt8(ascii: "z")) || byte == UInt8(ascii: "-")
            }
        }
    }

    private static func isTeamIDByte(_ byte: UInt8) -> Bool {
        (byte >= UInt8(ascii: "A") && byte <= UInt8(ascii: "Z")) || (byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9"))
    }
}

/// Why an application identifier was rejected.
public enum AppIdentifierError: Error, Sendable, Hashable {
    /// There is no `.` separating a Team ID from the bundle identifier.
    case missingTeamID(String)
    /// The Team ID is not 10 uppercase letters or digits.
    case invalidTeamID(String)
    /// The bundle identifier is empty, too long or contains characters other than letters,
    /// digits, `-` and `.`.
    case invalidBundleIdentifier(String)
}
