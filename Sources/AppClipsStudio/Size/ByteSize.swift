import Foundation

/// Parsing and formatting of decimal byte sizes, written so that no input can trap.
enum ByteSize {
    /// The largest size accepted from text: 1 TB, far above any App Clip and far below
    /// `Int64.max`, so the conversion from `Double` cannot overflow.
    static let maximumBytes: Int64 = 1_000_000_000_000

    private static let multipliers: [String: Double] = [
        "bytes": 1, "byte": 1, "B": 1,
        "KB": 1_000, "MB": 1_000_000, "GB": 1_000_000_000
    ]

    /// Parses a number such as `6.7`, `6,7`, `512` or `Zero` with a unit such as `MB`.
    ///
    /// Only ASCII digits with at most one `.` or `,` are numbers, so `nan`, `inf`, `1e999`,
    /// `-1` and `0x10` are rejected before `Double` sees them.
    static func parse(_ number: Substring, unit: Substring) -> Int64? {
        guard let multiplier = multipliers[String(unit)] else { return nil }
        if number == "Zero" { return 0 }
        let separators = number.filter { $0 == "." || $0 == "," }
        guard !number.isEmpty, separators.count <= 1,
              number.first != "." && number.first != ",",
              number.allSatisfy({ $0.isASCII && ($0.isNumber || $0 == "." || $0 == ",") }),
              let value = Double(number.replacingOccurrences(of: ",", with: ".")) else {
            return nil
        }
        let bytes = (value * multiplier).rounded()
        guard bytes.isFinite, bytes >= 0, bytes <= Double(maximumBytes) else { return nil }
        return Int64(bytes)
    }

    /// Parses ASCII digits into an integer no larger than `maximum`, or returns `nil`.
    static func boundedInteger(_ text: String, maximum: Int) -> Int? {
        guard !text.isEmpty, text.utf8.count <= 9,
              text.utf8.allSatisfy({ $0 >= UInt8(ascii: "0") && $0 <= UInt8(ascii: "9") }),
              let value = Int(text), value <= maximum else {
            return nil
        }
        return value
    }
}
