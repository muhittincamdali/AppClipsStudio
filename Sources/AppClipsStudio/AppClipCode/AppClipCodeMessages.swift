import Foundation

/// The explanations shown for App Clip Code URL findings.
enum AppClipCodeMessages {
    static func message(for kind: AppClipCodeFinding.Kind) -> String {
        switch kind {
        case .tooLong(let limit):
            "The URL is longer than \(limit) bytes; no App Clip Code can hold it."
        case .schemeNotLowercaseHTTPS:
            "The URL must start with \"https://\" in lowercase."
        case .missingHost:
            "The URL has no host."
        case .invalidHostCharacter(let character):
            "The host contains \"\(character)\"; only lowercase a-z, \".\" and \"-\" are allowed."
        case .invalidCharacter(let character):
            "The path, query or fragment contains \"\(character)\"; only a-z, A-Z, 0-9 and /#?=%-._,+;:& are allowed."
        case .wwwSubdomain:
            "Remove the \"www\" subdomain if your site allows it."
        case .appClipSubdomainNotFirst:
            "The \"appclip\" subdomain encodes efficiently only as the first subdomain."
        case .trailingSlash:
            "Remove the trailing \"/\"."
        case .multiplePathComponents(let count):
            "The path has \(count) components; use one at most, or none."
        case .uncommonPathWord(let word):
            "\"\(word)\" is not one of the path words that encode efficiently, such as \"shop\" or \"menu\"."
        case .unorderedQueryNames:
            "Name query items p, p1, p2, … in order."
        case .longIdentifier(let value):
            "\"\(value)\" looks like a UUID; use a short identifier."
        case .nonDecimalQueryValue(let value):
            "\"\(value)\" is not a decimal number; numbers encode more efficiently."
        }
    }
}
