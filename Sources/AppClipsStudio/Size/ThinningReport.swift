import Foundation

/// The variants and sizes in an `App Thinning Size Report.txt` that Xcode writes when it exports
/// an App Clip with App Thinning.
///
/// Each variant block looks like this:
///
/// ```text
/// Variant: ExampleClip.ipa
/// Supported variant descriptors: [device: iPhone11,4, os-version: 16.0], [device: iPhone9,4, os-version: 16.0]
/// App + On Demand Resources size: 6.7 MB compressed, 14.6 MB uncompressed
/// App size: 6.7 MB compressed, 14.6 MB uncompressed
/// On Demand Resources size: Zero KB compressed, Zero KB uncompressed
/// ```
///
/// The parser reads the `App size` line (App Clips can't use On Demand Resources) and falls back
/// to `App + On Demand Resources size`. It rejects reports larger than ``maximumReportBytes``
/// and sizes that are not plain decimal numbers, so `nan`, `inf` or `1e999` never become a size.
public struct ThinningReport: Sendable, Hashable {
    /// One exported variant.
    public struct Variant: Sendable, Hashable {
        /// The variant's file name, such as `ExampleClip.ipa`.
        public let name: String
        /// The `os-version` values of its descriptors, as written; empty for `Universal`.
        public let osVersions: [String]
        /// The download size in bytes.
        public let compressedBytes: Int64
        /// The installed size in bytes, which Apple's limits apply to.
        public let uncompressedBytes: Int64

        /// The lowest iOS major version among the descriptors, or `nil` when none is given.
        public var lowestOSMajorVersion: Int? {
            osVersions.compactMap { version in
                let major = version.split(separator: ".").first.map(String.init) ?? version
                return ByteSize.boundedInteger(major, maximum: SizeBudget.latestDeploymentTarget)
            }.min()
        }
    }

    /// The largest report accepted, in UTF-8 bytes.
    public static let maximumReportBytes = 8 * 1024 * 1024
    /// The most variants accepted.
    public static let maximumVariants = 4096
    /// The most descriptors read per variant; the rest of a longer list is ignored.
    public static let maximumDescriptorsPerVariant = 1024

    /// The app name from the first line, if present.
    public let appName: String?
    /// The variants in report order.
    public let variants: [Variant]

    /// Parses the text of a size report.
    public init(parsing text: String) throws(ThinningReportError) {
        guard text.utf8.count <= Self.maximumReportBytes else {
            throw .tooLarge(bytes: text.utf8.count, limit: Self.maximumReportBytes)
        }
        var parser = Parser()
        for (index, line) in text.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline).enumerated() {
            try parser.read(line.trimmingCharacters(in: .whitespaces), lineNumber: index + 1)
        }
        let variants = try parser.finish()
        guard !variants.isEmpty else { throw .noVariants }
        self.appName = parser.appName
        self.variants = variants
    }
}

private struct Parser {
    private static let titlePrefix = "App Thinning Size Report for All Variants of "

    var appName: String?
    private var variants: [ThinningReport.Variant] = []
    private var name: String?
    private var osVersions: [String] = []
    private var appSize: (compressed: Int64, uncompressed: Int64)?
    private var combinedSize: (compressed: Int64, uncompressed: Int64)?

    mutating func read(_ line: String, lineNumber: Int) throws(ThinningReportError) {
        if line.hasPrefix(Self.titlePrefix) {
            appName = String(line.dropFirst(Self.titlePrefix.count))
        } else if let value = line.value(after: "Variant:") {
            try finishVariant()
            guard variants.count < ThinningReport.maximumVariants else {
                throw .tooManyVariants(limit: ThinningReport.maximumVariants)
            }
            name = value
        } else if let value = line.value(after: "Supported variant descriptors:") {
            osVersions = Self.osVersions(in: value)
        } else if let value = line.value(after: "App size:") {
            appSize = try Self.sizes(value, lineNumber: lineNumber)
        } else if let value = line.value(after: "App + On Demand Resources size:") {
            combinedSize = try Self.sizes(value, lineNumber: lineNumber)
        }
    }

    mutating func finish() throws(ThinningReportError) -> [ThinningReport.Variant] {
        try finishVariant()
        return variants
    }

    private mutating func finishVariant() throws(ThinningReportError) {
        guard let name else { return }
        guard let size = appSize ?? combinedSize else { throw .missingSize(variant: name) }
        variants.append(.init(name: name, osVersions: osVersions, compressedBytes: size.compressed, uncompressedBytes: size.uncompressed))
        self.name = nil
        osVersions = []
        appSize = nil
        combinedSize = nil
    }

    /// Reads `os-version` from each `[device: …, os-version: …]` group.
    private static func osVersions(in descriptors: String) -> [String] {
        descriptors.split(separator: "[").prefix(ThinningReport.maximumDescriptorsPerVariant).compactMap { group in
            guard let close = group.firstIndex(of: "]") else { return nil }
            let fields = group[..<close].split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            return fields.first { $0.hasPrefix("os-version:") }
                .map { String($0.dropFirst("os-version:".count)).trimmingCharacters(in: .whitespaces) }
        }
    }

    /// Parses `6.7 MB compressed, 18.6 MB uncompressed`. The parts are separated by a comma and
    /// a space, so a decimal comma (`6,7 MB`) stays inside its number.
    private static func sizes(_ text: String, lineNumber: Int) throws(ThinningReportError) -> (Int64, Int64) {
        var compressed: Int64?
        var uncompressed: Int64?
        for part in text.components(separatedBy: ", ") {
            let words = part.split(separator: " ")
            guard words.count == 3 else { continue }
            guard let bytes = ByteSize.parse(words[0], unit: words[1]) else {
                throw .invalidSize(line: lineNumber, text: String(part.trimmingCharacters(in: .whitespaces)))
            }
            switch words[2] {
            case "compressed": compressed = bytes
            case "uncompressed": uncompressed = bytes
            default: continue
            }
        }
        guard let compressed, let uncompressed else {
            throw .invalidSize(line: lineNumber, text: text)
        }
        return (compressed, uncompressed)
    }
}

/// Why a size report could not be read.
public enum ThinningReportError: Error, Sendable, Hashable {
    /// The report is larger than ``ThinningReport/maximumReportBytes``.
    case tooLarge(bytes: Int, limit: Int)
    /// The report has more variants than ``ThinningReport/maximumVariants``.
    case tooManyVariants(limit: Int)
    /// The report contains no `Variant:` blocks.
    case noVariants
    /// A variant has no `App size` line.
    case missingSize(variant: String)
    /// A size is not a plain decimal number with a known unit.
    case invalidSize(line: Int, text: String)
}

private extension String {
    func value(after prefix: String) -> String? {
        guard hasPrefix(prefix) else { return nil }
        return dropFirst(prefix.count).trimmingCharacters(in: .whitespaces)
    }
}
