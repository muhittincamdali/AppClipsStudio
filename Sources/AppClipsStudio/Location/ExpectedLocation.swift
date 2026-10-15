import Foundation
#if canImport(CoreLocation)
import CoreLocation
#endif

/// Where an App Clip expects to be invoked, for the system's location confirmation.
///
/// An App Clip invoked from an NFC tag or a visual code can ask the system to confirm that the
/// person is near the place the code belongs to. Apple requires a circular region with a radius
/// of up to 500 meters. `ExpectedLocation` checks the values before they reach CoreLocation:
/// coordinates must be finite and in range, and the radius must be greater than 0 and at most
/// ``maximumRadius``.
public struct ExpectedLocation: Sendable, Hashable, Codable {
    /// The largest radius Apple accepts for location confirmation, in meters.
    public static let maximumRadius: Double = 500

    /// The latitude in degrees, from -90 to 90.
    public let latitude: Double
    /// The longitude in degrees, from -180 to 180.
    public let longitude: Double
    /// The radius in meters, greater than 0 and at most 500.
    public let radius: Double
    /// A name for the region, such as a store number.
    public let identifier: String

    /// Creates a location, or throws when a value is out of range or not a number.
    public init(latitude: Double, longitude: Double, radius: Double, identifier: String) throws(ExpectedLocationError) {
        guard latitude.isFinite, (-90...90).contains(latitude) else { throw .invalidLatitude(latitude) }
        guard longitude.isFinite, (-180...180).contains(longitude) else { throw .invalidLongitude(longitude) }
        guard radius.isFinite, radius > 0, radius <= Self.maximumRadius else { throw .invalidRadius(radius) }
        guard !identifier.isEmpty else { throw .emptyIdentifier }
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.identifier = identifier
    }

    /// Decodes and validates, so a location read from a server or a file passes the same checks.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            latitude: container.decode(Double.self, forKey: .latitude),
            longitude: container.decode(Double.self, forKey: .longitude),
            radius: container.decode(Double.self, forKey: .radius),
            identifier: container.decode(String.self, forKey: .identifier)
        )
    }

    private enum CodingKeys: String, CodingKey { case latitude, longitude, radius, identifier }

    #if canImport(CoreLocation)
    /// The region to pass to `APActivationPayload.confirmAcquired(in:completionHandler:)`.
    public var region: CLCircularRegion {
        CLCircularRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            radius: radius,
            identifier: identifier
        )
    }
    #endif
}

/// Why a location was rejected.
public enum ExpectedLocationError: Error, Sendable, Hashable {
    /// The latitude is NaN, infinite or outside -90...90.
    case invalidLatitude(Double)
    /// The longitude is NaN, infinite or outside -180...180.
    case invalidLongitude(Double)
    /// The radius is NaN, infinite, not positive or larger than 500 meters.
    case invalidRadius(Double)
    /// The identifier is empty.
    case emptyIdentifier
}
