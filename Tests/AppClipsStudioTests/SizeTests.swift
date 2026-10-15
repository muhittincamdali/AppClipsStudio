import Foundation
import Testing
@testable import AppClipsStudio

@Suite("Size budget")
struct SizeBudgetTests {
    private let megabyte: Int64 = 1_000_000

    @Test(arguments: [
        (14, InvocationSupport.physical, 10), (15, .digitalOnly, 10), (15, .demoLink, 10),
        (16, .physical, 15), (16, .digitalOnly, 15), (16, .demoLink, 15),
        (17, .physical, 15), (17, .digitalOnly, 100), (17, .demoLink, 100), (26, .digitalOnly, 100)
    ] as [(Int, InvocationSupport, Int64)])
    func limitForTheDeploymentTarget(target: Int, invocations: InvocationSupport, megabytes: Int64) throws {
        let budget = try SizeBudget(deploymentTarget: target, invocations: invocations)
        #expect(budget.limit() == megabytes * megabyte)
    }

    @Test func variantsUseTheirOwnOSVersion() throws {
        let digital16 = try SizeBudget(deploymentTarget: 16, invocations: .digitalOnly)
        #expect(digital16.limit(forOSMajorVersion: 17) == 15 * megabyte, "100 MB needs an iOS 17 deployment target")
        let demo16 = try SizeBudget(deploymentTarget: 16, invocations: .demoLink)
        #expect(demo16.limit(forOSMajorVersion: 16) == 15 * megabyte)
        #expect(demo16.limit(forOSMajorVersion: 18) == 100 * megabyte)
        let physical15 = try SizeBudget(deploymentTarget: 15, invocations: .physical)
        #expect(physical15.limit(forOSMajorVersion: 15) == 10 * megabyte)
        #expect(physical15.limit(forOSMajorVersion: 16) == 15 * megabyte)
        #expect(physical15.limit(forOSMajorVersion: 12) == 10 * megabyte, "a variant below the target uses the target")
    }

    @Test(arguments: [13, 0, -1, 100, Int.max, Int.min])
    func rejectsUnsupportedDeploymentTargets(target: Int) {
        #expect(throws: SizeBudgetError.unsupportedDeploymentTarget(target)) {
            try SizeBudget(deploymentTarget: target, invocations: .physical)
        }
    }

    @Test func evaluationWithoutEntriesDoesNotPass() throws {
        let budget = try SizeBudget(deploymentTarget: 16, invocations: .physical)
        #expect(!SizeEvaluation(budget: budget, entries: []).passes)
    }
}

@Suite("Thinning report")
struct ThinningReportTests {
    /// The sample from Apple's "Reducing your app's size", with App Clip variants.
    static let sample = """
        App Thinning Size Report for All Variants of ExampleClip

        Variant: ExampleClip-1.ipa
        Supported variant descriptors: [device: iPhone11,4, os-version: 16.0], [device: iPhone9,4, os-version: 16.0], and [device: iPhone10,2, os-version: 16.0]
        App + On Demand Resources size: 6.7 MB compressed, 14.6 MB uncompressed
        App size: 6.7 MB compressed, 14.6 MB uncompressed
        On Demand Resources size: Zero KB compressed, Zero KB uncompressed

        Variant: ExampleClip-2.ipa
        Supported variant descriptors: [device: iPhone15,2, os-version: 17.0]
        App + On Demand Resources size: 7,1 MB compressed, 15.2 MB uncompressed
        App size: 7,1 MB compressed, 15.2 MB uncompressed
        On Demand Resources size: Zero KB compressed, Zero KB uncompressed

        Variant: ExampleClip-universal.ipa
        Supported variant descriptors: Universal
        App size: 900 KB compressed, 1.2 GB uncompressed
        """

    @Test func parsesVariantsAndSizes() throws {
        let report = try ThinningReport(parsing: Self.sample)
        #expect(report.appName == "ExampleClip")
        #expect(report.variants.map(\.name) == ["ExampleClip-1.ipa", "ExampleClip-2.ipa", "ExampleClip-universal.ipa"])
        #expect(report.variants.map(\.uncompressedBytes) == [14_600_000, 15_200_000, 1_200_000_000])
        #expect(report.variants.map(\.compressedBytes) == [6_700_000, 7_100_000, 900_000])
        #expect(report.variants[0].osVersions == ["16.0", "16.0", "16.0"])
        #expect(report.variants.map(\.lowestOSMajorVersion) == [16, 17, nil])
    }

    @Test func evaluatesEachVariantAgainstItsLimit() throws {
        let report = try ThinningReport(parsing: Self.sample)
        let evaluation = try SizeBudget(deploymentTarget: 16, invocations: .physical).evaluate(report)
        #expect(evaluation.entries.map(\.limitBytes) == [15_000_000, 15_000_000, 15_000_000])
        #expect(evaluation.entries.map(\.isWithinLimit) == [true, false, false])
        #expect(evaluation.entries[0].headroomBytes == 400_000)
        #expect(!evaluation.passes)
    }

    @Test func fallsBackToTheCombinedSizeLine() throws {
        let report = try ThinningReport(parsing: """
            Variant: A.ipa
            App + On Demand Resources size: 1 MB compressed, 2 MB uncompressed
            """)
        #expect(report.variants.first?.uncompressedBytes == 2_000_000)
        #expect(report.appName == nil)
    }

    @Test(arguments: ["nan", "inf", "-inf", "1e999", "1e3", "-1", "0x10", "1.2.3", "1,2.3", ".5", "", "١٢", "99999999999999"])
    func rejectsSizesThatAreNotPlainDecimals(number: String) {
        let text = "Variant: A.ipa\nApp size: 1 MB compressed, \(number) MB uncompressed\n"
        #expect(throws: ThinningReportError.self) {
            try ThinningReport(parsing: text)
        }
    }

    @Test func rejectsUnknownUnits() {
        #expect(throws: ThinningReportError.invalidSize(line: 2, text: "2 TB uncompressed")) {
            try ThinningReport(parsing: "Variant: A.ipa\nApp size: 1 MB compressed, 2 TB uncompressed")
        }
    }

    @Test func countsLinesAcrossLineEndings() throws {
        let text = "\r\n\n\rVariant: A.ipa\r\n\u{2028}App size: 1 MB compressed, 2 TB uncompressed\n"
        #expect(throws: ThinningReportError.invalidSize(line: 6, text: "2 TB uncompressed")) {
            try ThinningReport(parsing: text)
        }
        let report = try ThinningReport(parsing: "\n\nVariant: A.ipa\r\nApp size: 1 MB compressed, 2 MB uncompressed\n")
        #expect(report.variants.map(\.name) == ["A.ipa"])
    }

    @Test func rejectsReportsWithoutVariantsOrSizes() {
        #expect(throws: ThinningReportError.noVariants) { try ThinningReport(parsing: "hello") }
        #expect(throws: ThinningReportError.missingSize(variant: "A.ipa")) {
            try ThinningReport(parsing: "Variant: A.ipa\nVariant: B.ipa\nApp size: 1 MB compressed, 1 MB uncompressed")
        }
    }

    @Test func rejectsOversizedReportsBeforeParsing() {
        let text = String(repeating: "x", count: ThinningReport.maximumReportBytes + 1)
        #expect(throws: ThinningReportError.tooLarge(bytes: text.utf8.count, limit: ThinningReport.maximumReportBytes)) {
            try ThinningReport(parsing: text)
        }
    }

    @Test func rejectsTooManyVariants() {
        let block = "Variant: V.ipa\nApp size: 1 MB compressed, 1 MB uncompressed\n"
        let text = String(repeating: block, count: ThinningReport.maximumVariants + 1)
        #expect(throws: ThinningReportError.tooManyVariants(limit: ThinningReport.maximumVariants)) {
            try ThinningReport(parsing: text)
        }
    }

    @Test func readsAtMostTheDescriptorLimit() throws {
        let many = (0..<2000).map { "[device: iPhone1,1, os-version: \(14 + $0 % 3).0]" }.joined(separator: ", ")
        let report = try ThinningReport(parsing: "Variant: A.ipa\nSupported variant descriptors: \(many)\nApp size: 1 MB compressed, 1 MB uncompressed")
        #expect(report.variants.first?.osVersions.count == ThinningReport.maximumDescriptorsPerVariant)
        #expect(report.variants.first?.lowestOSMajorVersion == 14)
    }

    @Test func hugeOSVersionsAreIgnoredInsteadOfTrapping() throws {
        let report = try ThinningReport(parsing: """
            Variant: A.ipa
            Supported variant descriptors: [device: iPhone1,1, os-version: 99999999999999999999.0], [device: iPhone1,1, os-version: x]
            App size: 1 MB compressed, 1 MB uncompressed
            """)
        #expect(report.variants.first?.lowestOSMajorVersion == nil)
    }

    @Test func byteSizeParsingStaysWithinBounds() {
        #expect(ByteSize.parse("Zero", unit: "KB") == 0)
        #expect(ByteSize.parse("512", unit: "bytes") == 512)
        #expect(ByteSize.parse("1000", unit: "GB") == 1_000_000_000_000)
        #expect(ByteSize.parse("1001", unit: "GB") == nil)
        #expect(ByteSize.parse("1.5", unit: "MiB") == nil)
    }
}
