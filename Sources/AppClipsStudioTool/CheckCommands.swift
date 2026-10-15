import AppClipsStudio
import Foundation

/// `appclipstudio check-url`: App Clip Code URL rules.
enum URLCommand {
    struct Report: Encodable {
        let url: String
        let findings: [AppClipCodeFinding]
    }

    static func run(_ arguments: [String]) throws(ToolError) -> ToolResult {
        let arguments = try Arguments(arguments, flagOptions: ["--json"])
        guard !arguments.positional.isEmpty else { throw .usage("check-url needs at least one URL.") }
        guard arguments.positional.count <= 100 else { throw .usage("check-url checks at most 100 URLs at a time.") }
        let reports = arguments.positional.map { Report(url: $0, findings: AppClipCodeURLCheck.findings(for: $0)) }
        let failed = reports.contains { $0.findings.contains { $0.severity == .error } }
        let output = arguments.has("--json") ? reports.jsonLine() : reports.map(text).joined()
        return ToolResult(exitCode: failed ? 1 : 0, standardOutput: output, standardError: "")
    }

    private static func text(_ report: Report) -> String {
        var lines = [ToolError.printable(report.url)]
        if report.findings.isEmpty {
            lines.append("  ok: follows every rule Apple documents for App Clip Code URLs.")
        }
        for finding in report.findings {
            lines.append("  \(finding.severity.rawValue): \(finding.message)")
        }
        return lines.joined(separator: "\n") + "\n"
    }
}

/// `appclipstudio check-domain`: Associated Domains entitlement entries.
enum DomainCommand {
    struct Report: Encodable {
        let entry: String
        let valid: Bool
        let message: String
    }

    static func run(_ arguments: [String]) throws(ToolError) -> ToolResult {
        let arguments = try Arguments(arguments, flagOptions: ["--json"])
        guard !arguments.positional.isEmpty else { throw .usage("check-domain needs at least one entry, such as appclips:example.com.") }
        guard arguments.positional.count <= 100 else { throw .usage("check-domain checks at most 100 entries at a time.") }
        let reports = arguments.positional.map(report)
        let output = arguments.has("--json")
            ? reports.jsonLine()
            : reports.map { "\($0.valid ? "ok   " : "error") \(ToolError.printable($0.entry)): \($0.message)\n" }.joined()
        return ToolResult(exitCode: reports.allSatisfy(\.valid) ? 0 : 1, standardOutput: output, standardError: "")
    }

    static func report(_ entry: String) -> Report {
        do throws(AssociatedDomainError) {
            let domain = try AssociatedDomain(entry)
            let file = domain.associationFileURL?.absoluteString ?? ""
            return Report(entry: entry, valid: true, message: "serve the association file at \(file)")
        } catch {
            return Report(entry: entry, valid: false, message: message(error))
        }
    }

    private static func message(_ error: AssociatedDomainError) -> String {
        switch error {
        case .tooLong(let limit): "longer than \(limit) characters"
        case .missingService: "start with a service, such as appclips: or applinks:"
        case .unknownService(let service): "\(ToolError.printable(service)) is not applinks, webcredentials, activitycontinuation or appclips"
        case .invalidMode(let mode): "\(ToolError.printable(mode)) is not mode=developer, mode=managed or mode=developer+managed"
        case .wildcardNotAllowedForAppClips: "appclips entries can't use a *. wildcard"
        case .missingDomain: "no domain after the service"
        case .containsPath: "remove the path or trailing slash; use the domain only"
        case .containsPort: "remove the port; Apple's format is <service>:<fully qualified domain>"
        case .notFullyQualified: "use a fully qualified domain, such as example.com"
        case .invalidDomain: "the domain has an empty, too long or invalid label"
        }
    }
}
