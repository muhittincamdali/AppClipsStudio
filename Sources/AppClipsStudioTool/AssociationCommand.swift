import AppClipsStudio
import Foundation

/// `appclipstudio aasa validate` and `appclipstudio aasa generate`.
enum AssociationCommand {
    static func run(_ arguments: [String]) throws(ToolError) -> ToolResult {
        switch arguments.first {
        case "validate": try validate(Array(arguments.dropFirst()))
        case "generate": try generate(Array(arguments.dropFirst()))
        default: throw .usage("aasa takes validate or generate.")
        }
    }

    private static func validate(_ arguments: [String]) throws(ToolError) -> ToolResult {
        let arguments = try Arguments(arguments, valueOptions: ["--app-clip"], flagOptions: ["--json"])
        guard arguments.positional.count == 1, let path = arguments.positional.first else {
            throw .usage("aasa validate takes one file.")
        }
        let expected = try arguments.value("--app-clip").map { text throws(ToolError) in try identifier(text, option: "--app-clip") }
        let validator = AssociationFileValidator()
        let data = try FileInput.data(at: URL(fileURLWithPath: path), limit: validator.maximumBytes)
        let findings = validator.findings(in: data, expectingAppClip: expected)
        let failed = findings.contains { $0.severity == .error }
        let output: String
        if arguments.has("--json") {
            output = findings.jsonLine()
        } else if findings.isEmpty {
            output = "ok: \(ToolError.printable(path)) lists the App Clip and its full app.\n"
        } else {
            output = findings.map { "\($0.severity.rawValue): \($0.message)\n" }.joined()
        }
        return ToolResult(exitCode: failed ? 1 : 0, standardOutput: output, standardError: "")
    }

    private static func generate(_ arguments: [String]) throws(ToolError) -> ToolResult {
        let arguments = try Arguments(arguments, valueOptions: ["--app", "--app-clip", "--path"])
        guard arguments.positional.isEmpty else { throw .usage("aasa generate takes only options.") }
        guard let appText = arguments.value("--app"), let clipText = arguments.value("--app-clip") else {
            throw .usage("aasa generate needs --app and --app-clip, such as ABCDE12345.com.example.MyApp.")
        }
        let paths = arguments.allValues("--path")
        guard paths.count <= 100 else { throw .usage("aasa generate takes at most 100 --path values.") }
        let app = try identifier(appText, option: "--app")
        let clip = try identifier(clipText, option: "--app-clip")
        let file: AssociationFile
        do throws(AssociationFileError) {
            file = try AssociationFile(app: app, appClip: clip, universalLinkPaths: paths.isEmpty ? ["*"] : paths)
        } catch {
            switch error {
            case .appClipNotInApp:
                throw .usage("The App Clip's identifier must be the app's followed by a suffix, such as \(app).Clip.")
            case .invalidPath(let path):
                throw .usage("--path \(ToolError.printable(path)) must start with / or be *, without control or format characters.")
            }
        }
        guard let data = try? file.jsonData() else { throw .input("Could not encode the file.") }
        return ToolResult(exitCode: 0, standardOutput: String(decoding: data, as: UTF8.self) + "\n", standardError: "")
    }

    private static func identifier(_ text: String, option: String) throws(ToolError) -> AppIdentifier {
        do {
            return try AppIdentifier(text)
        } catch {
            throw .usage("\(option) \(ToolError.printable(text)) is not a Team ID followed by a bundle identifier, such as ABCDE12345.com.example.MyApp.")
        }
    }
}
