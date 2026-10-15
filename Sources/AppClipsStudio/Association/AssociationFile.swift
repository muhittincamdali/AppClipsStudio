import Foundation

/// Builds the `apple-app-site-association` file that associates an App Clip and its full app
/// with a website.
///
/// ```swift
/// let file = try AssociationFile(
///     app: AppIdentifier("ABCDE12345.com.example.MyApp"),
///     appClip: AppIdentifier("ABCDE12345.com.example.MyApp.Clip"),
///     universalLinkPaths: ["/order/*", "/menu"]
/// )
/// let json = try file.jsonData()   // serve at https://example.com/.well-known/apple-app-site-association
/// ```
///
/// The `appclips` service lists the App Clip; the `applinks` service lets the full app, which
/// replaces the App Clip once installed, open the same URLs as universal links.
public struct AssociationFile: Sendable, Hashable {
    /// The full app.
    public let app: AppIdentifier
    /// The App Clip.
    public let appClip: AppIdentifier
    /// The paths the full app opens as universal links, in AASA component syntax (`*` and `?`
    /// wildcards). Empty leaves out the `applinks` service.
    public let universalLinkPaths: [String]

    /// Creates a file, or throws when the App Clip's identifier doesn't extend the app's.
    public init(app: AppIdentifier, appClip: AppIdentifier, universalLinkPaths: [String] = ["*"]) throws(AssociationFileError) {
        guard appClip.isAppClip(of: app) else {
            throw .appClipNotInApp(appClip: appClip.description, app: app.description)
        }
        for path in universalLinkPaths where !path.hasPrefix("/") && path != "*" {
            throw .invalidPath(path)
        }
        self.app = app
        self.appClip = appClip
        self.universalLinkPaths = universalLinkPaths
    }

    /// The file's JSON, pretty-printed with sorted keys.
    public func jsonData() throws -> Data {
        var root: [String: Any] = ["appclips": ["apps": [appClip.description]]]
        if !universalLinkPaths.isEmpty {
            let components = universalLinkPaths.map { ["/": $0] }
            root["applinks"] = ["details": [["appIDs": [app.description], "components": components]]]
        }
        return try JSONSerialization.data(withJSONObject: root, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes])
    }
}

/// Why an association file could not be built.
public enum AssociationFileError: Error, Sendable, Hashable {
    /// The App Clip's identifier is not the app's identifier followed by a suffix.
    case appClipNotInApp(appClip: String, app: String)
    /// A universal link path doesn't start with `/` and isn't `*`.
    case invalidPath(String)
}
