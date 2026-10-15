import AppClipsStudio
import Foundation

/// `appclipstudio size`: checks a size report or an `.app` folder against the App Clip limit.
enum SizeCommand {
    static func run(_ arguments: [String]) throws(ToolError) -> ToolResult {
        let arguments = try Arguments(arguments, valueOptions: ["--deployment-target", "--invocations"], flagOptions: ["--json"])
        guard arguments.positional.count == 1, let path = arguments.positional.first else {
            throw .usage("size takes one path: a size report or an .app folder.")
        }
        guard let target = arguments.value("--deployment-target") else {
            throw .usage("size needs --deployment-target, the App Clip's minimum iOS version, such as 16.0.")
        }
        let budget = try budget(target: target, invocations: arguments.value("--invocations") ?? "physical")
        let evaluation = try evaluate(path: path, budget: budget)
        let output = arguments.has("--json") ? evaluation.jsonLine() : text(evaluation)
        return ToolResult(exitCode: evaluation.passes ? 0 : 1, standardOutput: output, standardError: "")
    }

    static func budget(target: String, invocations: String) throws(ToolError) -> SizeBudget {
        let support: InvocationSupport
        switch invocations {
        case "physical": support = .physical
        case "digital": support = .digitalOnly
        case "demo": support = .demoLink
        default: throw .usage("--invocations is physical, digital or demo, not \(ToolError.printable(invocations)).")
        }
        let major = target.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false).first.map(String.init) ?? ""
        guard major.count <= 3, major.utf8.allSatisfy({ $0 >= UInt8(ascii: "0") && $0 <= UInt8(ascii: "9") }),
              let version = Int(major) else {
            throw .usage("--deployment-target must be an iOS version such as 16.0, not \(ToolError.printable(target)).")
        }
        do {
            return try SizeBudget(deploymentTarget: version, invocations: support)
        } catch {
            throw .usage("App Clips run on iOS 14 and later; \(version) is not a supported deployment target.")
        }
    }

    private static func evaluate(path: String, budget: SizeBudget) throws(ToolError) -> SizeEvaluation {
        let url = URL(fileURLWithPath: path)
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) else {
            throw .input("No file or folder at \(ToolError.printable(path)).")
        }
        if isDirectory.boolValue {
            do {
                return budget.evaluate(try BundleSizeScanner().scan(url), name: url.lastPathComponent)
            } catch {
                throw .input("Could not measure \(ToolError.printable(path)): \(error).")
            }
        }
        let text = try FileInput.text(at: url, limit: ThinningReport.maximumReportBytes)
        do throws(ThinningReportError) {
            return budget.evaluate(try ThinningReport(parsing: text))
        } catch {
            throw .input("\(ToolError.printable(path)) is not an App Thinning Size Report: \(describe(error)).")
        }
    }

    private static func describe(_ error: ThinningReportError) -> String {
        switch error {
        case .tooLarge(let bytes, let limit): "it is \(bytes) bytes, more than \(limit)"
        case .tooManyVariants(let limit): "it has more than \(limit) variants"
        case .noVariants: "it has no \"Variant:\" lines"
        case .missingSize(let variant): "variant \(ToolError.printable(variant)) has no \"App size\" line"
        case .invalidSize(let line, let text): "line \(line) has an unreadable size \"\(ToolError.printable(text))\""
        }
    }

    static func text(_ evaluation: SizeEvaluation) -> String {
        var lines = ["App Clip size check (iOS \(evaluation.budget.deploymentTarget)+, \(label(evaluation.budget.invocations)) invocations)"]
        let width = min(48, evaluation.entries.map { ToolError.printable($0.name).count }.max() ?? 0)
        for entry in evaluation.entries {
            let name = ToolError.printable(entry.name).padding(toLength: max(width, 1), withPad: " ", startingAt: 0)
            let status = entry.isWithinLimit ? "ok  " : "OVER"
            lines.append("  \(status) \(name)  \(megabytes(entry.uncompressedBytes)) of \(megabytes(entry.limitBytes))")
        }
        let failing = evaluation.entries.filter { !$0.isWithinLimit }.count
        lines.append(failing == 0
            ? "All \(evaluation.entries.count) variants are within the limit."
            : "\(failing) of \(evaluation.entries.count) variants are over the limit.")
        return lines.joined(separator: "\n") + "\n"
    }

    private static func label(_ support: InvocationSupport) -> String {
        switch support {
        case .physical: "physical and digital"
        case .digitalOnly: "digital-only"
        case .demoLink: "demo link"
        }
    }

    /// Decimal megabytes with two decimals, the unit of Xcode's size report.
    static func megabytes(_ bytes: Int64) -> String {
        String(format: "%.2f MB", Double(bytes) / 1_000_000)
    }
}

/// Reads input files with a size limit, so a huge or endless file can't exhaust memory.
enum FileInput {
    static func data(at url: URL, limit: Int) throws(ToolError) -> Data {
        let handle: FileHandle
        do {
            handle = try FileHandle(forReadingFrom: url)
        } catch {
            throw .input("Could not open \(ToolError.printable(url.path)).")
        }
        defer { try? handle.close() }
        let data: Data
        do {
            data = try handle.read(upToCount: limit + 1) ?? Data()
        } catch {
            throw .input("Could not read \(ToolError.printable(url.path)).")
        }
        guard data.count <= limit else {
            throw .input("\(ToolError.printable(url.path)) is larger than \(limit) bytes.")
        }
        return data
    }

    static func text(at url: URL, limit: Int) throws(ToolError) -> String {
        let data = try data(at: url, limit: limit)
        guard let text = String(data: data, encoding: .utf8) else {
            throw .input("\(ToolError.printable(url.path)) is not UTF-8 text.")
        }
        return text
    }
}
