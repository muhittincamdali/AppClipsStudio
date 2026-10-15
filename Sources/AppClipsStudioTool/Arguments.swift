import Foundation

/// The parsed command line of one subcommand: positional values, options with a value and flags.
struct Arguments {
    private(set) var positional: [String] = []
    private var values: [String: [String]] = [:]
    private var flags: Set<String> = []

    /// Parses `arguments`; `valueOptions` take the next argument as their value and
    /// `flagOptions` take none. Anything else starting with `--` is a usage error.
    init(_ arguments: [String], valueOptions: Set<String> = [], flagOptions: Set<String> = []) throws(ToolError) {
        var index = arguments.startIndex
        while index < arguments.endIndex {
            let argument = arguments[index]
            index += 1
            if argument == "--" {
                positional += arguments[index...]
                break
            }
            guard argument.hasPrefix("--") else {
                positional.append(argument)
                continue
            }
            if flagOptions.contains(argument) {
                flags.insert(argument)
            } else if valueOptions.contains(argument) {
                guard index < arguments.endIndex else { throw .usage("\(argument) needs a value.") }
                values[argument, default: []].append(arguments[index])
                index += 1
            } else {
                throw .usage("Unknown option \(ToolError.printable(argument)).")
            }
        }
    }

    /// The last value given for an option.
    func value(_ option: String) -> String? {
        values[option]?.last
    }

    /// Every value given for an option, in order.
    func allValues(_ option: String) -> [String] {
        values[option] ?? []
    }

    /// Whether a flag was given.
    func has(_ flag: String) -> Bool {
        flags.contains(flag)
    }
}

/// A failure that ends the command with exit code 2.
enum ToolError: Error, Equatable {
    case usage(String)
    case input(String)

    var message: String {
        switch self {
        case .usage(let text): "error: \(text)\nRun 'appclipstudio help' for usage."
        case .input(let text): "error: \(text)"
        }
    }

    /// Arguments and paths shown in messages, with control and format characters (including
    /// C1 controls and bidirectional overrides) replaced by `?` and cut to 200 characters.
    static func printable(_ text: String) -> String {
        let hidden: Set<Unicode.GeneralCategory> = [.control, .format, .lineSeparator, .paragraphSeparator]
        let cleaned = String(text.prefix(200).map { character -> Character in
            character.unicodeScalars.contains { hidden.contains($0.properties.generalCategory) } ? "?" : character
        })
        return text.count > 200 ? cleaned + "…" : cleaned
    }
}
