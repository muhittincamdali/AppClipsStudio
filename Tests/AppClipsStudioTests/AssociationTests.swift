import Foundation
import Testing
@testable import AppClipsStudio

@Suite("App identifiers and associated domains")
struct AppIdentifierTests {
    @Test func parsesTeamAndBundleIdentifier() throws {
        let identifier = try AppIdentifier("ABCDE12345.com.example.MyApp.Clip")
        #expect(identifier.teamID == "ABCDE12345")
        #expect(identifier.bundleIdentifier == "com.example.MyApp.Clip")
        #expect(identifier.description == "ABCDE12345.com.example.MyApp.Clip")
        #expect(identifier.parentCandidate?.description == "ABCDE12345.com.example.MyApp")
    }

    @Test(arguments: ["ABCDE12345", "abcde12345.com.example", "ABCDE1234.com.example", "ABCDE123456.com.example",
                      "ABCDE12345.", "ABCDE12345.com..example", "ABCDE12345.com.exa mple", "ABCDE12345.com.ex_ample",
                      "ABCDE12345.com.exämple", ""])
    func rejectsMalformedIdentifiers(text: String) {
        #expect(throws: AppIdentifierError.self) { try AppIdentifier(text) }
    }

    @Test func rejectsOverlongBundleIdentifiers() {
        #expect(throws: AppIdentifierError.self) {
            try AppIdentifier("ABCDE12345." + String(repeating: "a", count: 256))
        }
    }

    @Test func recognizesAnAppClipOfAnApp() throws {
        let app = try AppIdentifier("ABCDE12345.com.example.MyApp")
        #expect(try AppIdentifier("ABCDE12345.com.example.MyApp.Clip").isAppClip(of: app))
        #expect(try !AppIdentifier("ABCDE12345.com.example.MyAppClip").isAppClip(of: app))
        #expect(try !AppIdentifier("ZZZZZ12345.com.example.MyApp.Clip").isAppClip(of: app))
        #expect(!app.isAppClip(of: app))
    }

    @Test func parsesAssociatedDomains() throws {
        let clip = try AssociatedDomain("appclips:appclip.example.com")
        #expect(clip.service == .appclips)
        #expect(clip.domain == "appclip.example.com")
        #expect(clip.associationFileURL?.absoluteString == "https://appclip.example.com/.well-known/apple-app-site-association")
        let links = try AssociatedDomain("applinks:*.Example.com?mode=developer+managed")
        #expect(links.includesSubdomains)
        #expect(links.domain == "example.com")
        #expect(links.mode == .developerAndManaged)
        #expect(links.description == "applinks:*.example.com?mode=developer+managed")
    }

    @Test(arguments: [
        ("appclips:*.example.com", AssociatedDomainError.wildcardNotAllowedForAppClips),
        ("appclips:example.com/", .containsPath("example.com/")),
        ("appclips:example.com/menu", .containsPath("example.com/menu")),
        ("appclips:example.com:8443", .containsPort("example.com:8443")),
        ("appclips:localhost", .notFullyQualified("localhost")),
        ("appclips:", .missingDomain),
        ("example.com", .missingService),
        ("universal:example.com", .unknownService("universal")),
        ("applinks:example.com?mode=debug", .invalidMode("mode=debug")),
        ("applinks:example.com?foo=bar", .invalidMode("foo=bar")),
        ("applinks:-example.com", .invalidDomain("-example.com")),
        ("applinks:exa_mple.com", .invalidDomain("exa_mple.com")),
        ("applinks:example..com", .invalidDomain("example..com"))
    ])
    func rejectsInvalidEntries(entry: String, expected: AssociatedDomainError) {
        #expect(throws: expected) { try AssociatedDomain(entry) }
    }

    @Test func rejectsOverlongEntriesAndLabels() {
        #expect(throws: AssociatedDomainError.tooLong(limit: 300)) {
            try AssociatedDomain("applinks:" + String(repeating: "a.", count: 200) + "com")
        }
        let label = String(repeating: "a", count: 64)
        #expect(throws: AssociatedDomainError.invalidDomain("\(label).com")) {
            try AssociatedDomain("applinks:\(label).com")
        }
    }
}

@Suite("Association file")
struct AssociationFileTests {
    private let validator = AssociationFileValidator()

    private func data(_ json: String) -> Data { Data(json.utf8) }

    private func kinds(_ json: String, expecting: String? = nil) throws -> [AssociationFinding.Kind] {
        let expected = try expecting.map { try AppIdentifier($0) }
        return validator.findings(in: data(json), expectingAppClip: expected).map(\.kind)
    }

    @Test func generatedFilePassesValidation() throws {
        let file = try AssociationFile(
            app: AppIdentifier("ABCDE12345.com.example.MyApp"),
            appClip: AppIdentifier("ABCDE12345.com.example.MyApp.Clip"),
            universalLinkPaths: ["/order/*", "/menu"]
        )
        let json = try file.jsonData()
        let clip = try AppIdentifier("ABCDE12345.com.example.MyApp.Clip")
        #expect(validator.findings(in: json, expectingAppClip: clip).isEmpty)
        let object = try #require(JSONSerialization.jsonObject(with: json) as? [String: Any])
        let apps = (object["appclips"] as? [String: Any])?["apps"] as? [String]
        #expect(apps == ["ABCDE12345.com.example.MyApp.Clip"])
        let text = String(decoding: json, as: UTF8.self)
        #expect(text.contains("\"/\" : \"/order/*\""))
    }

    @Test func generatorRejectsMismatchedIdentifiersAndPaths() throws {
        let app = try AppIdentifier("ABCDE12345.com.example.MyApp")
        #expect(throws: AssociationFileError.appClipNotInApp(appClip: "ABCDE12345.com.other.Clip", app: app.description)) {
            try AssociationFile(app: app, appClip: AppIdentifier("ABCDE12345.com.other.Clip"))
        }
        #expect(throws: AssociationFileError.invalidPath("order")) {
            try AssociationFile(app: app, appClip: AppIdentifier("ABCDE12345.com.example.MyApp.Clip"), universalLinkPaths: ["order"])
        }
        for path in ["/order\u{9B}31m", "/\u{202E}redro", "/a\nb", "/a\u{2028}b"] {
            #expect(throws: AssociationFileError.invalidPath(path)) {
                try AssociationFile(app: app, appClip: AppIdentifier("ABCDE12345.com.example.MyApp.Clip"), universalLinkPaths: [path])
            }
        }
    }

    @Test func generatorCanLeaveOutUniversalLinks() throws {
        let file = try AssociationFile(
            app: AppIdentifier("ABCDE12345.com.example.MyApp"),
            appClip: AppIdentifier("ABCDE12345.com.example.MyApp.Clip"),
            universalLinkPaths: []
        )
        #expect(try kinds(String(decoding: file.jsonData(), as: UTF8.self)) == [
            .fullAppNotInAppLinks(appClip: "ABCDE12345.com.example.MyApp.Clip", app: "ABCDE12345.com.example.MyApp")
        ])
    }

    @Test func acceptsAppleSampleFile() throws {
        let sample = """
            {"applinks": {"details": [{"appIDs": ["ABCDE12345.com.example.MyApp"], "components": [{"/": "/buy/*"}]}]},
             "webcredentials": {"apps": ["ABCDE12345.com.example.MyApp"]},
             "appclips": {"apps": ["ABCDE12345.com.example.MyApp.Clip"]}}
            """
        #expect(try kinds(sample, expecting: "ABCDE12345.com.example.MyApp.Clip").isEmpty)
        let legacy = #"{"applinks": {"details": [{"appID": "ABCDE12345.com.example.MyApp", "paths": ["*"]}]}, "appclips": {"apps": ["ABCDE12345.com.example.MyApp.Clip"]}}"#
        #expect(try kinds(legacy).isEmpty)
    }

    @Test func reportsStructuralErrors() throws {
        #expect(try kinds("{") == [.invalidJSON])
        #expect(try kinds("[]") == [.notAnObject])
        #expect(try kinds("{}") == [.missingAppClips])
        #expect(try kinds(#"{"appclips": {"apps": []}}"#) == [.emptyAppClips])
        #expect(try kinds(#"{"appclips": ["ABCDE12345.a.b"]}"#) == [.malformedService("appclips")])
        #expect(try kinds(#"{"appclips": {"apps": [42]}}"#) == [.malformedService("appclips")])
        #expect(try kinds(#"{"appclips": {"apps": ["com.example.Clip"]}}"#) == [.invalidAppID(service: "appclips", value: "com.example.Clip")])
    }

    @Test func reportsAnExpectedAppClipThatIsMissing() throws {
        let json = #"{"appclips": {"apps": ["ABCDE12345.com.example.MyApp.Clip"]}, "applinks": {"details": [{"appIDs": ["ABCDE12345.com.example.MyApp"]}]}}"#
        #expect(try kinds(json, expecting: "ABCDE12345.com.example.Other.Clip") == [.appClipNotListed("ABCDE12345.com.example.Other.Clip")])
    }

    @Test func warnsAboutMissingFullAppAndUnknownServices() throws {
        let json = #"{"appclips": {"apps": ["ABCDE12345.com.example.MyApp.Clip"]}, "aplinks": {}}"#
        let findings = validator.findings(in: data(json))
        #expect(findings.map(\.kind) == [
            .fullAppNotInAppLinks(appClip: "ABCDE12345.com.example.MyApp.Clip", app: "ABCDE12345.com.example.MyApp"),
            .unknownService("aplinks")
        ])
        #expect(findings.allSatisfy { $0.severity == .warning })
    }

    @Test func errorsComeBeforeWarnings() throws {
        let json = #"{"zzz": 1, "appclips": {"apps": ["ABCDE12345.com.example.MyApp.Clip", "bad"]}}"#
        let severities = validator.findings(in: data(json)).map(\.severity)
        #expect(severities == [.error, .warning, .warning])
    }

    @Test func unknownKeysAreShownSafely() throws {
        let json = "{\"appclips\": {\"apps\": [\"ABCDE12345.a.b\"]}, \"applinks\": {\"details\": [{\"appIDs\": [\"ABCDE12345.a\"]}]}, \"\\u001b[2Jx\": 1}"
        #expect(try kinds(json) == [.unknownService("?[2Jx")])
    }

    @Test func rejectsOversizedFilesWithoutParsing() {
        let small = AssociationFileValidator(maximumBytes: 10)
        #expect(small.findings(in: Data(count: 11)).map(\.kind) == [.tooLarge(bytes: 11, limit: 10)])
    }

    @Test func deeplyNestedJSONDoesNotCrash() {
        let deep = String(repeating: "[", count: 100_000) + String(repeating: "]", count: 100_000)
        let kinds = AssociationFileValidator().findings(in: Data(deep.utf8)).map(\.kind)
        #expect(kinds == [.invalidJSON] || kinds == [.notAnObject])
    }
}
