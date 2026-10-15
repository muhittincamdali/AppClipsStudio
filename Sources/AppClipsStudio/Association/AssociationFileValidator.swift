import Foundation

/// Checks an `apple-app-site-association` file before you deploy it.
///
/// It reports what keeps the system or App Store Connect from verifying an App Clip: invalid
/// JSON, a missing `appclips` service, malformed app identifiers, or an expected App Clip that
/// isn't listed. As a warning, it reports App Clips whose full app (the identifier without its
/// last component) can't open the same URLs through `applinks`.
///
/// ```swift
/// let findings = AssociationFileValidator().findings(in: data, expectingAppClip: clipID)
/// if findings.contains(where: { $0.severity == .error }) { … }
/// ```
public struct AssociationFileValidator: Sendable {
    /// The largest file read, in bytes; larger files give one error without being parsed.
    public let maximumBytes: Int

    /// The top-level keys Apple documents.
    public static let knownServices: Set<String> = ["applinks", "webcredentials", "appclips", "activitycontinuation"]

    /// Creates a validator.
    public init(maximumBytes: Int = 512 * 1024) {
        self.maximumBytes = maximumBytes
    }

    /// Returns every problem in the file, errors first.
    public func findings(in data: Data, expectingAppClip expected: AppIdentifier? = nil) -> [AssociationFinding] {
        guard data.count <= maximumBytes else {
            return [AssociationFinding(.tooLarge(bytes: data.count, limit: maximumBytes))]
        }
        guard let object = try? JSONSerialization.jsonObject(with: data) else {
            return [AssociationFinding(.invalidJSON)]
        }
        guard let root = object as? [String: Any] else {
            return [AssociationFinding(.notAnObject)]
        }
        var findings: [AssociationFinding] = []
        let clips = appClipIdentifiers(in: root, findings: &findings)
        let linkApps = appLinkIdentifiers(in: root, findings: &findings)
        if let webcredentials = root["webcredentials"] {
            _ = identifiers(in: webcredentials, service: "webcredentials", findings: &findings)
        }
        if let expected, !clips.contains(expected) {
            findings.append(AssociationFinding(.appClipNotListed(expected.description)))
        }
        for clip in clips {
            guard let parent = clip.parentCandidate, !linkApps.contains(parent) else { continue }
            findings.append(AssociationFinding(.fullAppNotInAppLinks(appClip: clip.description, app: parent.description)))
        }
        for key in root.keys.sorted() where !Self.knownServices.contains(key) {
            findings.append(AssociationFinding(.unknownService(AssociationFinding.printable(key))))
        }
        return findings.filter { $0.severity == .error } + findings.filter { $0.severity != .error }
    }

    private func appClipIdentifiers(in root: [String: Any], findings: inout [AssociationFinding]) -> [AppIdentifier] {
        guard let service = root["appclips"] else {
            findings.append(AssociationFinding(.missingAppClips))
            return []
        }
        let clips = identifiers(in: service, service: "appclips", findings: &findings)
        if let apps = (service as? [String: Any])?["apps"] as? [Any], apps.isEmpty {
            findings.append(AssociationFinding(.emptyAppClips))
        }
        return clips
    }

    /// Reads `{"apps": [...]}`.
    private func identifiers(in service: Any, service name: String, findings: inout [AssociationFinding]) -> [AppIdentifier] {
        guard let apps = (service as? [String: Any])?["apps"] as? [Any] else {
            findings.append(AssociationFinding(.malformedService(name)))
            return []
        }
        return parse(apps, service: name, findings: &findings)
    }

    /// Reads `{"details": [{"appIDs": [...]} or {"appID": "..."}]}`.
    private func appLinkIdentifiers(in root: [String: Any], findings: inout [AssociationFinding]) -> [AppIdentifier] {
        guard let service = root["applinks"] else { return [] }
        guard let details = (service as? [String: Any])?["details"] as? [Any] else {
            findings.append(AssociationFinding(.malformedService("applinks")))
            return []
        }
        var result: [AppIdentifier] = []
        for detail in details {
            guard let detail = detail as? [String: Any] else {
                findings.append(AssociationFinding(.malformedService("applinks")))
                continue
            }
            var values: [Any] = (detail["appIDs"] as? [Any]) ?? []
            if let single = detail["appID"] { values.append(single) }
            if values.isEmpty { findings.append(AssociationFinding(.malformedService("applinks"))) }
            result += parse(values, service: "applinks", findings: &findings)
        }
        return result
    }

    private func parse(_ values: [Any], service: String, findings: inout [AssociationFinding]) -> [AppIdentifier] {
        values.compactMap { value in
            guard let text = value as? String else {
                findings.append(AssociationFinding(.malformedService(service)))
                return nil
            }
            do {
                return try AppIdentifier(text)
            } catch {
                findings.append(AssociationFinding(.invalidAppID(service: service, value: AssociationFinding.printable(text))))
                return nil
            }
        }
    }
}
