import Foundation
import Testing
@testable import AppClipsStudioTool

@Suite("appclipstudio")
struct ToolTests {
    private let folder: URL

    init() throws {
        folder = FileManager.default.temporaryDirectory.appendingPathComponent("AppClipsStudioToolTests-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
    }

    private func file(_ name: String, _ contents: String) throws -> String {
        let url = folder.appendingPathComponent(name)
        try Data(contents.utf8).write(to: url)
        return url.path
    }

    private static let report = """
        App Thinning Size Report for All Variants of ExampleClip

        Variant: ExampleClip-a.ipa
        Supported variant descriptors: [device: iPhone11,4, os-version: 16.0]
        App size: 6.7 MB compressed, 14.6 MB uncompressed

        Variant: ExampleClip-b.ipa
        Supported variant descriptors: [device: iPhone15,2, os-version: 17.0]
        App size: 7.1 MB compressed, 15.2 MB uncompressed
        """

    @Test func printsUsageAndVersion() {
        #expect(Tool.run([]).exitCode == 2)
        let help = Tool.run(["help"])
        #expect(help.exitCode == 0)
        #expect(help.standardOutput.contains("appclipstudio size"))
        #expect(Tool.run(["--version"]).standardOutput == "\(Tool.version)\n")
        let unknown = Tool.run(["deploy"])
        #expect(unknown.exitCode == 2)
        #expect(unknown.standardError.contains("Unknown command deploy"))
    }

    @Test func sizeReportsVariantsOverTheLimit() throws {
        let path = try file("report.txt", Self.report)
        let physical = Tool.run(["size", path, "--deployment-target", "16.0"])
        #expect(physical.exitCode == 1)
        #expect(physical.standardOutput.contains("ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB"))
        #expect(physical.standardOutput.contains("OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB"))
        #expect(physical.standardOutput.contains("1 of 2 variants are over the limit."))

        let digital = Tool.run(["size", path, "--deployment-target", "17", "--invocations", "digital"])
        #expect(digital.exitCode == 0)
        #expect(digital.standardOutput.contains("All 2 variants are within the limit."))
    }

    @Test func sizeWritesJSON() throws {
        let path = try file("report.txt", Self.report)
        let result = Tool.run(["size", path, "--deployment-target", "16", "--json"])
        let object = try #require(JSONSerialization.jsonObject(with: Data(result.standardOutput.utf8)) as? [String: Any])
        let entries = try #require(object["entries"] as? [[String: Any]])
        #expect(entries.count == 2)
        #expect(entries.first?["uncompressedBytes"] as? Int == 14_600_000)
        #expect(entries.first?["limitBytes"] as? Int == 15_000_000)
    }

    @Test func sizeMeasuresAFolder() throws {
        let app = folder.appendingPathComponent("Clip.app")
        try FileManager.default.createDirectory(at: app, withIntermediateDirectories: true)
        try Data(count: 2_000_000).write(to: app.appendingPathComponent("Clip"))
        let result = Tool.run(["size", app.path, "--deployment-target", "15"])
        #expect(result.exitCode == 0)
        #expect(result.standardOutput.contains("Clip.app  2.00 MB of 10.00 MB"))
    }

    @Test(arguments: [
        ["size"], ["size", "a", "b", "--deployment-target", "16"], ["size", "x"],
        ["size", "x", "--deployment-target", "abc"], ["size", "x", "--deployment-target", "13"],
        ["size", "x", "--deployment-target", "99999999999999999999"], ["size", "x", "--deployment-target", "-16"],
        ["size", "x", "--deployment-target", "16", "--invocations", "nfc"], ["size", "x", "--deployment-target"],
        ["size", "x", "--deployment-target", "16", "--verbose"]
    ])
    func sizeUsageErrors(arguments: [String]) {
        let result = Tool.run(arguments)
        #expect(result.exitCode == 2)
        #expect(result.standardOutput.isEmpty)
        #expect(result.standardError.hasPrefix("error: "))
    }

    @Test func sizeInputErrors() throws {
        let missing = Tool.run(["size", folder.appendingPathComponent("none.txt").path, "--deployment-target", "16"])
        #expect(missing.exitCode == 2)
        #expect(missing.standardError.contains("No file or folder"))
        let notReport = Tool.run(["size", try file("notes.txt", "hello"), "--deployment-target", "16"])
        #expect(notReport.exitCode == 2)
        #expect(notReport.standardError.contains("has no \"Variant:\" lines"))
        let nanSize = Tool.run(["size", try file("nan.txt", "Variant: A\nApp size: nan MB compressed, nan MB uncompressed"), "--deployment-target", "16"])
        #expect(nanSize.exitCode == 2)
        #expect(nanSize.standardError.contains("unreadable size"))
    }

    @Test func sizeRefusesHugeFilesWithoutReadingThemWhole() throws {
        let url = folder.appendingPathComponent("huge.txt")
        FileManager.default.createFile(atPath: url.path, contents: nil)
        let handle = try FileHandle(forWritingTo: url)
        try handle.truncate(atOffset: UInt64(64 * 1024 * 1024))
        try handle.close()
        let result = Tool.run(["size", url.path, "--deployment-target", "16"])
        #expect(result.exitCode == 2)
        #expect(result.standardError.contains("is larger than"))
    }

    @Test func checkURLReportsErrorsAndSuggestions() {
        let good = Tool.run(["check-url", "https://appclip.example.com/shop?p=1"])
        #expect(good.exitCode == 0)
        #expect(good.standardOutput.contains("ok: follows every rule"))
        let suggestions = Tool.run(["check-url", "https://www.example.com/"])
        #expect(suggestions.exitCode == 0)
        #expect(suggestions.standardOutput.contains("suggestion: Remove the \"www\" subdomain"))
        let bad = Tool.run(["check-url", "https://example.com/ok", "http://example.com"])
        #expect(bad.exitCode == 1)
        #expect(bad.standardOutput.contains("error: The URL must start with \"https://\""))
    }

    @Test func checkURLNeverEchoesControlCharacters() {
        let result = Tool.run(["check-url", "https://example.com/\u{1B}]0;title\u{07}"])
        #expect(result.exitCode == 1)
        #expect(!result.standardOutput.contains("\u{1B}"))
        #expect(!result.standardOutput.contains("\u{07}"))
        #expect(result.standardOutput.contains("U+001B"))
        let bidi = Tool.run(["check-domain", "applinks:\u{202E}moc.elpmaxe"])
        #expect(!bidi.standardOutput.contains("\u{202E}"))
    }

    @Test func checkURLWritesJSON() throws {
        let result = Tool.run(["check-url", "--json", "https://www.example.com"])
        let reports = try #require(JSONSerialization.jsonObject(with: Data(result.standardOutput.utf8)) as? [[String: Any]])
        let findings = try #require(reports.first?["findings"] as? [[String: String]])
        #expect(findings.first?["severity"] == "suggestion")
    }

    @Test func jsonEscapesC1AndFormatCharacters() throws {
        let url = "https://example.com/a\u{9B}31m\u{202E}b\u{2028}c\u{E0001}d"
        let result = Tool.run(["check-url", "--json", url])
        for hidden in ["\u{9B}", "\u{202E}", "\u{2028}", "\u{E0001}"] {
            #expect(!result.standardOutput.contains(hidden))
        }
        #expect(result.standardOutput.contains(#"\u009b"#))
        #expect(result.standardOutput.contains(#"\udb40\udc01"#))
        let reports = try #require(JSONSerialization.jsonObject(with: Data(result.standardOutput.utf8)) as? [[String: Any]])
        #expect(reports.first?["url"] as? String == url)
        #expect(escapingHiddenScalars("{\n  \"a\" : \"İ\"\n}") == "{\n  \"a\" : \"İ\"\n}")

        let report = Self.report.replacingOccurrences(of: "ExampleClip-a.ipa", with: "Clip\u{9B}2J\u{202E}.ipa")
        let size = Tool.run(["size", try file("report.txt", report), "--deployment-target", "16", "--json"])
        #expect(!size.standardOutput.contains("\u{9B}"))
        #expect(!size.standardOutput.contains("\u{202E}"))
        #expect(size.standardOutput.contains(#"Clip\u009b2J\u202e.ipa"#))
    }

    @Test func checkDomain() {
        let ok = Tool.run(["check-domain", "appclips:example.com", "applinks:*.example.com?mode=developer"])
        #expect(ok.exitCode == 0)
        #expect(ok.standardOutput.contains("https://example.com/.well-known/apple-app-site-association"))
        let bad = Tool.run(["check-domain", "appclips:*.example.com"])
        #expect(bad.exitCode == 1)
        #expect(bad.standardOutput.contains("can't use a *. wildcard"))
        #expect(Tool.run(["check-domain"]).exitCode == 2)
        #expect(Tool.run(["check-url"] + Array(repeating: "https://example.com", count: 101)).exitCode == 2)
    }

    @Test func generatedAssociationFileValidates() throws {
        let generated = Tool.run(["aasa", "generate", "--app", "ABCDE12345.com.example.MyApp", "--app-clip", "ABCDE12345.com.example.MyApp.Clip", "--path", "/order/*"])
        #expect(generated.exitCode == 0)
        let path = try file("apple-app-site-association", generated.standardOutput)
        let validated = Tool.run(["aasa", "validate", path, "--app-clip", "ABCDE12345.com.example.MyApp.Clip"])
        #expect(validated.exitCode == 0)
        #expect(validated.standardOutput.hasPrefix("ok: "))
        let otherClip = Tool.run(["aasa", "validate", path, "--app-clip", "ABCDE12345.com.example.Other.Clip"])
        #expect(otherClip.exitCode == 1)
        #expect(otherClip.standardOutput.contains("is not listed"))
    }

    @Test func associationErrors() throws {
        #expect(Tool.run(["aasa"]).exitCode == 2)
        #expect(Tool.run(["aasa", "generate", "--app", "ABCDE12345.com.example.MyApp"]).exitCode == 2)
        let mismatch = Tool.run(["aasa", "generate", "--app", "ABCDE12345.com.example.MyApp", "--app-clip", "ABCDE12345.com.other.Clip"])
        #expect(mismatch.exitCode == 2)
        #expect(mismatch.standardError.contains("ABCDE12345.com.example.MyApp.Clip"))
        #expect(Tool.run(["aasa", "generate", "--app", "bad", "--app-clip", "bad.Clip"]).exitCode == 2)
        #expect(Tool.run(["aasa", "generate", "--app", "ABCDE12345.a", "--app-clip", "ABCDE12345.a.b", "--path", "x"]).exitCode == 2)
        let invalid = Tool.run(["aasa", "validate", try file("broken.json", "{")])
        #expect(invalid.exitCode == 1)
        #expect(invalid.standardOutput == "error: The file is not valid JSON.\n")
        #expect(Tool.run(["aasa", "validate", try file("x.json", "{}"), "--app-clip", "nope"]).exitCode == 2)
    }

    @Test func argumentsSupportDoubleDash() throws {
        let arguments = try Arguments(["--json", "--", "--not-an-option"], flagOptions: ["--json"])
        #expect(arguments.has("--json"))
        #expect(arguments.positional == ["--not-an-option"])
    }

    @Test func printableRemovesControlAndFormatCharacters() {
        #expect(ToolError.printable("a\u{1B}b\u{9B}c\u{202E}d\ne") == "a?b?c?d?e")
        #expect(ToolError.printable("İstanbul") == "İstanbul")
        #expect(ToolError.printable(String(repeating: "x", count: 300)).count == 201)
    }
}
