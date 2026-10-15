import Foundation

/// How people can invoke an App Clip, which decides the size limit on iOS 17 and later.
public enum InvocationSupport: String, Sendable, Hashable, CaseIterable, Codable {
    /// Only digital invocations, such as your website, Messages or Spotlight.
    case digitalOnly
    /// Physical invocations too: App Clip Codes, QR codes or NFC tags.
    case physical
    /// The App Clip demo link from App Store Connect, which supports all invocations but
    /// can't carry URL parameters.
    case demoLink
}

/// The App Clip size limits Apple documents, applied to one App Clip's configuration.
///
/// Apple limits the uncompressed size of each App Clip variant:
///
/// | Device                  | Limit                                                           |
/// | ----------------------- | --------------------------------------------------------------- |
/// | iOS 15 and earlier      | 10 MB                                                           |
/// | iOS 16                  | 15 MB                                                           |
/// | iOS 17 and later        | 100 MB with a demo link, or digital-only invocations and an     |
/// |                         | iOS 17 deployment target; otherwise 15 MB                       |
///
/// Sizes are decimal: 1 MB is 1,000,000 bytes, the unit Xcode's size report uses.
public struct SizeBudget: Sendable, Hashable, Encodable {
    /// The App Clip's minimum iOS major version.
    public let deploymentTarget: Int
    /// How people invoke the App Clip.
    public let invocations: InvocationSupport

    /// The lowest iOS version that runs App Clips.
    public static let earliestDeploymentTarget = 14
    /// A bound on the deployment target that keeps arithmetic on it safe.
    public static let latestDeploymentTarget = 99

    /// Creates a budget, or throws when the deployment target is outside 14...99.
    public init(deploymentTarget: Int, invocations: InvocationSupport) throws(SizeBudgetError) {
        let range = Self.earliestDeploymentTarget...Self.latestDeploymentTarget
        guard range.contains(deploymentTarget) else {
            throw .unsupportedDeploymentTarget(deploymentTarget)
        }
        self.deploymentTarget = deploymentTarget
        self.invocations = invocations
    }

    /// The limit, in bytes, for a variant that runs on this iOS major version. Pass `nil` when
    /// the variant does not say, and the deployment target is used.
    public func limit(forOSMajorVersion osVersion: Int? = nil) -> Int64 {
        let os = max(osVersion ?? deploymentTarget, deploymentTarget)
        if os <= 15 { return 10 * Self.megabyte }
        if os == 16 { return 15 * Self.megabyte }
        let qualifiesForLargeLimit = invocations == .demoLink
            || (invocations == .digitalOnly && deploymentTarget >= 17)
        return (qualifiesForLargeLimit ? 100 : 15) * Self.megabyte
    }

    /// Checks each variant of a size report against its limit.
    public func evaluate(_ report: ThinningReport) -> SizeEvaluation {
        let entries = report.variants.map { variant in
            SizeEvaluation.Entry(
                name: variant.name,
                uncompressedBytes: variant.uncompressedBytes,
                limitBytes: limit(forOSMajorVersion: variant.lowestOSMajorVersion)
            )
        }
        return SizeEvaluation(budget: self, entries: entries)
    }

    /// Checks a measured bundle against the limit for the deployment target.
    public func evaluate(_ bundle: BundleSize, name: String) -> SizeEvaluation {
        let entry = SizeEvaluation.Entry(name: name, uncompressedBytes: bundle.totalBytes, limitBytes: limit())
        return SizeEvaluation(budget: self, entries: [entry])
    }

    static let megabyte: Int64 = 1_000_000
}

/// The result of checking sizes against a ``SizeBudget``.
public struct SizeEvaluation: Sendable, Hashable, Encodable {
    /// One checked variant or bundle.
    public struct Entry: Sendable, Hashable, Encodable {
        /// The variant's file name or the bundle's name.
        public let name: String
        /// The uncompressed size in bytes.
        public let uncompressedBytes: Int64
        /// The limit that applies to it, in bytes.
        public let limitBytes: Int64

        /// Whether the size is within the limit.
        public var isWithinLimit: Bool { uncompressedBytes <= limitBytes }
        /// Bytes left before the limit; negative when over it.
        public var headroomBytes: Int64 { limitBytes - uncompressedBytes }
    }

    /// The budget that was applied.
    public let budget: SizeBudget
    /// One entry per variant, in report order.
    public let entries: [Entry]

    /// Whether every entry is within its limit. An evaluation without entries does not pass.
    public var passes: Bool {
        !entries.isEmpty && entries.allSatisfy(\.isWithinLimit)
    }
}

/// Why a size budget could not be created.
public enum SizeBudgetError: Error, Sendable, Hashable {
    /// The deployment target is not an iOS version between 14 and 99.
    case unsupportedDeploymentTarget(Int)
}
