import AppClipsStudio
import Foundation

/// What a command printed and how it ended.
public struct ToolResult: Equatable, Sendable {
    /// 0 when everything passed, 1 when a check found an error or a size over its limit, 2 for
    /// usage and input errors.
    public var exitCode: Int32
    /// The report.
    public var standardOutput: String
    /// Errors about the command itself.
    public var standardError: String
}

/// The `appclipstudio` command-line tool.
public enum Tool {
    /// The tool's version.
    public static let version = "2.0.0"

    /// Runs the tool with the arguments after the program name.
    public static func run(_ arguments: [String]) -> ToolResult {
        guard let command = arguments.first else {
            return ToolResult(exitCode: 2, standardOutput: "", standardError: usage)
        }
        let rest = Array(arguments.dropFirst())
        do throws(ToolError) {
            switch command {
            case "size": return try SizeCommand.run(rest)
            case "check-url": return try URLCommand.run(rest)
            case "check-domain": return try DomainCommand.run(rest)
            case "aasa": return try AssociationCommand.run(rest)
            case "help", "--help", "-h": return ToolResult(exitCode: 0, standardOutput: usage, standardError: "")
            case "--version": return ToolResult(exitCode: 0, standardOutput: version + "\n", standardError: "")
            default: throw ToolError.usage("Unknown command \(ToolError.printable(command)).")
            }
        } catch {
            return ToolResult(exitCode: 2, standardOutput: "", standardError: error.message + "\n")
        }
    }

    static let usage = """
        appclipstudio \(version): checks for App Clip projects.

        USAGE
          appclipstudio size <App Thinning Size Report.txt | Clip.app> --deployment-target <iOS version>
                             [--invocations physical|digital|demo] [--json]
              Checks each variant's uncompressed size against Apple's App Clip limit.
          appclipstudio check-url <url>... [--json]
              Checks URLs against Apple's rules for App Clip Codes.
          appclipstudio check-domain <entry>... [--json]
              Checks Associated Domains entitlement entries, such as appclips:example.com.
          appclipstudio aasa validate <file> [--app-clip <TEAMID.bundle.id>] [--json]
              Checks an apple-app-site-association file.
          appclipstudio aasa generate --app <TEAMID.bundle.id> --app-clip <TEAMID.bundle.id> [--path <path>]...
              Prints an apple-app-site-association file for the app and its App Clip.

        EXIT STATUS
          0 passed, 1 a check failed, 2 usage or input error.

        """
}

extension Encodable {
    /// Pretty-printed JSON with sorted keys and a final newline.
    func jsonLine() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        guard let data = try? encoder.encode(self) else { return "{}\n" }
        return String(decoding: data, as: UTF8.self) + "\n"
    }
}
