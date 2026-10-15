import Foundation

/// The outcome of asking the system to confirm a person's location on App Clip launch.
///
/// Update your interface for every case, including the ones where nothing could be confirmed.
public enum LocationConfirmation: Sendable, Hashable {
    /// The invocation happened inside the expected region.
    case confirmed
    /// The invocation happened outside the region, for example because someone moved the tag.
    case notInRegion
    /// The invocation URL isn't registered for this App Clip.
    case urlNotRegistered
    /// The person denied location access, or the App Clip wasn't invoked from an NFC tag or a
    /// visual code.
    case unavailable
    /// The system reported an error this package doesn't know, with its domain and code.
    case failed(domain: String, code: Int)

    /// The `APActivationPayloadErrorDomain` codes Apple documents.
    enum PayloadErrorCode: Int {
        case disallowed = 1
        case doesNotMatch = 2
    }

    /// Maps the system's completion values to a case.
    ///
    /// - Parameters:
    ///   - inRegion: The Boolean the system passes.
    ///   - error: The error the system passes, if any.
    ///   - payloadErrorDomain: `APActivationPayloadErrorDomain`; a parameter so the mapping can
    ///     be tested on platforms without the AppClip framework.
    init(inRegion: Bool, error: (any Error)?, payloadErrorDomain: String) {
        guard let error else {
            self = inRegion ? .confirmed : .notInRegion
            return
        }
        let nsError = error as NSError
        guard nsError.domain == payloadErrorDomain, let code = PayloadErrorCode(rawValue: nsError.code) else {
            self = .failed(domain: nsError.domain, code: nsError.code)
            return
        }
        switch code {
        case .disallowed: self = .unavailable
        case .doesNotMatch: self = .urlNotRegistered
        }
    }
}

#if os(iOS) && canImport(AppClip)
import AppClip
import CoreLocation

extension APActivationPayload {
    /// Asks the system whether the App Clip was invoked inside `location`.
    ///
    /// Requires `NSAppClipRequestLocationConfirmation` set to `true` in the `NSAppClip`
    /// dictionary of the App Clip's `Info.plist`. Get the payload from
    /// `NSUserActivity.appClipActivationPayload` on launch.
    @MainActor
    public func confirm(_ location: ExpectedLocation) async -> LocationConfirmation {
        await withCheckedContinuation { continuation in
            confirmAcquired(in: location.region) { inRegion, error in
                continuation.resume(returning: LocationConfirmation(
                    inRegion: inRegion,
                    error: error,
                    payloadErrorDomain: APActivationPayloadErrorDomain
                ))
            }
        }
    }
}
#endif
