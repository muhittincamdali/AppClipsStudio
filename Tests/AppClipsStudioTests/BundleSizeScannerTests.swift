import Foundation
import Testing
@testable import AppClipsStudio

@Suite("Bundle size scanner")
struct BundleSizeScannerTests {
    private let root: URL

    init() throws {
        root = FileManager.default.temporaryDirectory
            .appendingPathComponent("AppClipsStudioTests-\(UUID().uuidString)")
            .appendingPathComponent("Clip.app")
        try FileManager.default.createDirectory(at: root.appendingPathComponent("Frameworks/Kit.framework"), withIntermediateDirectories: true)
        try write(1_000, to: "Clip")
        try write(300, to: "Info.plist")
        try write(5_000, to: "Assets.car")
        try write(2_000, to: "Frameworks/Kit.framework/Kit")
    }

    private func write(_ count: Int, to path: String) throws {
        try Data(repeating: 1, count: count).write(to: root.appendingPathComponent(path))
    }

    @Test func addsUpRegularFilesAndListsTheLargest() throws {
        let size = try BundleSizeScanner(largestFileCount: 2).scan(root)
        #expect(size.totalBytes == 8_300)
        #expect(size.fileCount == 4)
        #expect(size.largestFiles.map(\.path) == ["Assets.car", "Frameworks/Kit.framework/Kit"])
        #expect(size.largestFiles.map(\.bytes) == [5_000, 2_000])
    }

    @Test func doesNotFollowSymbolicLinks() throws {
        // A link back to the bundle would loop forever if it were followed.
        try FileManager.default.createSymbolicLink(at: root.appendingPathComponent("Loop"), withDestinationURL: root)
        try FileManager.default.createSymbolicLink(at: root.appendingPathComponent("Alias.car"), withDestinationURL: root.appendingPathComponent("Assets.car"))
        let size = try BundleSizeScanner().scan(root)
        #expect(size.totalBytes == 8_300)
        #expect(size.fileCount == 4)
    }

    @Test func stopsAfterTheFileLimit() {
        #expect(throws: BundleScanError.tooManyFiles(limit: 3)) {
            try BundleSizeScanner(maximumFiles: 3).scan(root)
        }
    }

    @Test func rejectsFilesAndMissingPaths() {
        let file = root.appendingPathComponent("Info.plist")
        #expect(throws: BundleScanError.notADirectory(file.path)) { try BundleSizeScanner().scan(file) }
        let missing = root.appendingPathComponent("Nope")
        #expect(throws: BundleScanError.notADirectory(missing.path)) { try BundleSizeScanner().scan(missing) }
    }

    @Test func zeroLargestFilesKeepsTheListEmpty() throws {
        let size = try BundleSizeScanner(largestFileCount: -5).scan(root)
        #expect(size.largestFiles.isEmpty)
        #expect(size.totalBytes == 8_300)
    }

    @Test func evaluatesTheBundleAgainstTheDeploymentTargetLimit() throws {
        let size = try BundleSizeScanner().scan(root)
        let evaluation = try SizeBudget(deploymentTarget: 16, invocations: .physical).evaluate(size, name: "Clip.app")
        #expect(evaluation.passes)
        #expect(evaluation.entries.first?.limitBytes == 15_000_000)
    }
}
