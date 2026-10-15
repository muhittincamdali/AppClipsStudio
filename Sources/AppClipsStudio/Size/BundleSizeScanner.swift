import Foundation

/// The measured size of a bundle folder.
public struct BundleSize: Sendable, Hashable, Encodable {
    /// One file and its size.
    public struct File: Sendable, Hashable, Encodable {
        /// The path relative to the bundle.
        public let path: String
        /// The size in bytes.
        public let bytes: Int64
    }

    /// The sum of all regular files, in bytes.
    public let totalBytes: Int64
    /// The number of regular files.
    public let fileCount: Int
    /// The largest files, biggest first.
    public let largestFiles: [File]
}

/// Adds up the files in an `.app` folder to estimate its uncompressed size.
///
/// Point it at a built App Clip, for example the `.app` inside an exported `.ipa` or in
/// `DerivedData`. The sum of file sizes is close to, but not the same as, the per-variant size
/// in Xcode's `App Thinning Size Report.txt`, which is what Apple checks; use
/// ``ThinningReport`` for the final answer.
///
/// The scan does not follow symbolic links, so a link that points back up the tree can't make it
/// loop, and it stops with ``BundleScanError/tooManyFiles(limit:)`` after ``maximumFiles``.
public struct BundleSizeScanner: Sendable {
    /// The most files scanned before giving up.
    public let maximumFiles: Int
    /// How many of the largest files to report.
    public let largestFileCount: Int

    /// Creates a scanner.
    public init(maximumFiles: Int = 100_000, largestFileCount: Int = 10) {
        self.maximumFiles = maximumFiles
        self.largestFileCount = max(0, largestFileCount)
    }

    /// Measures the folder at `url`.
    public func scan(_ url: URL) throws(BundleScanError) -> BundleSize {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory), isDirectory.boolValue else {
            throw .notADirectory(url.path)
        }
        let keys: [URLResourceKey] = [.isRegularFileKey, .fileSizeKey]
        let failure = FailureRecorder()
        guard let enumerator = FileManager.default.enumerator(
            at: url,
            includingPropertiesForKeys: keys,
            errorHandler: { failedURL, _ in
                failure.path = failedURL.path
                return false
            }
        ) else {
            throw .unreadable(url.path)
        }

        var total: Int64 = 0
        var count = 0
        var largest: [BundleSize.File] = []
        let root = url.standardizedFileURL.path
        for case let fileURL as URL in enumerator {
            guard let values = try? fileURL.resourceValues(forKeys: Set(keys)), values.isRegularFile == true else { continue }
            count += 1
            guard count <= maximumFiles else { throw .tooManyFiles(limit: maximumFiles) }
            let bytes = Int64(max(0, values.fileSize ?? 0))
            let sum = total.addingReportingOverflow(bytes)
            total = sum.overflow ? ByteSize.maximumBytes : min(sum.partialValue, ByteSize.maximumBytes)
            let file = BundleSize.File(path: Self.relativePath(fileURL, root: root), bytes: bytes)
            insert(file, into: &largest)
        }
        if let path = failure.path { throw .unreadable(path) }
        return BundleSize(totalBytes: total, fileCount: count, largestFiles: largest)
    }

    private func insert(_ file: BundleSize.File, into largest: inout [BundleSize.File]) {
        guard largestFileCount > 0 else { return }
        if largest.count == largestFileCount, let smallest = largest.last, smallest.bytes >= file.bytes {
            return
        }
        let index = largest.firstIndex { $0.bytes < file.bytes } ?? largest.endIndex
        largest.insert(file, at: index)
        if largest.count > largestFileCount {
            largest.removeLast()
        }
    }

    private static func relativePath(_ url: URL, root: String) -> String {
        let path = url.standardizedFileURL.path
        guard path.hasPrefix(root + "/") else { return url.lastPathComponent }
        return String(path.dropFirst(root.count + 1))
    }
}

/// Collects the first path the enumerator could not read.
private final class FailureRecorder: @unchecked Sendable {
    // Only touched synchronously during one scan on one thread.
    var path: String?
}

/// Why a bundle could not be measured.
public enum BundleScanError: Error, Sendable, Hashable {
    /// The path does not exist or is not a folder.
    case notADirectory(String)
    /// A file or folder could not be read.
    case unreadable(String)
    /// The folder holds more files than ``BundleSizeScanner/maximumFiles``.
    case tooManyFiles(limit: Int)
}
