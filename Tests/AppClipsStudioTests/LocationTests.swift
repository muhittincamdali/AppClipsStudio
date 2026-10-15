import Foundation
import Testing
@testable import AppClipsStudio

@Suite("Expected location")
struct LocationTests {
    @Test func acceptsValidLocations() throws {
        let location = try ExpectedLocation(latitude: 37.3347, longitude: -122.0089, radius: 100, identifier: "store-12")
        #expect(location.radius == 100)
        #expect(try ExpectedLocation(latitude: -90, longitude: 180, radius: 500, identifier: "edge").radius == 500)
        #if canImport(CoreLocation)
        let region = location.region
        #expect(region.radius == 100)
        #expect(region.center.latitude == 37.3347)
        #expect(region.identifier == "store-12")
        #endif
    }

    @Test(arguments: [Double.nan, .infinity, -.infinity, 90.000001, -91])
    func rejectsInvalidLatitudes(latitude: Double) {
        #expect(throws: ExpectedLocationError.self) {
            try ExpectedLocation(latitude: latitude, longitude: 0, radius: 10, identifier: "x")
        }
    }

    @Test(arguments: [Double.nan, .infinity, 180.5, -181])
    func rejectsInvalidLongitudes(longitude: Double) {
        #expect(throws: ExpectedLocationError.self) {
            try ExpectedLocation(latitude: 0, longitude: longitude, radius: 10, identifier: "x")
        }
    }

    @Test(arguments: [0, -1, 500.0001, 10_000, Double.nan, .infinity, -.infinity, .leastNonzeroMagnitude * -1])
    func rejectsRadiiOutsideAppleRange(radius: Double) {
        #expect(throws: ExpectedLocationError.self) {
            try ExpectedLocation(latitude: 0, longitude: 0, radius: radius, identifier: "x")
        }
    }

    @Test func rejectsEmptyIdentifier() {
        #expect(throws: ExpectedLocationError.emptyIdentifier) {
            try ExpectedLocation(latitude: 0, longitude: 0, radius: 10, identifier: "")
        }
    }

    @Test func decodingAppliesTheSameChecks() throws {
        let valid = #"{"latitude": 41.0, "longitude": 29.0, "radius": 250, "identifier": "kiosk"}"#
        let location = try JSONDecoder().decode(ExpectedLocation.self, from: Data(valid.utf8))
        #expect(location.radius == 250)
        let tooWide = #"{"latitude": 41.0, "longitude": 29.0, "radius": 5000, "identifier": "kiosk"}"#
        #expect(throws: ExpectedLocationError.invalidRadius(5000)) {
            try JSONDecoder().decode(ExpectedLocation.self, from: Data(tooWide.utf8))
        }
        let roundTrip = try JSONDecoder().decode(ExpectedLocation.self, from: JSONEncoder().encode(location))
        #expect(roundTrip == location)
    }
}

@Suite("Location confirmation")
struct LocationConfirmationTests {
    private let domain = "APActivationPayloadErrorDomain"

    @Test func mapsTheSystemResult() {
        #expect(LocationConfirmation(inRegion: true, error: nil, payloadErrorDomain: domain) == .confirmed)
        #expect(LocationConfirmation(inRegion: false, error: nil, payloadErrorDomain: domain) == .notInRegion)
        let disallowed = NSError(domain: domain, code: 1)
        #expect(LocationConfirmation(inRegion: false, error: disallowed, payloadErrorDomain: domain) == .unavailable)
        let doesNotMatch = NSError(domain: domain, code: 2)
        #expect(LocationConfirmation(inRegion: true, error: doesNotMatch, payloadErrorDomain: domain) == .urlNotRegistered)
    }

    @Test func keepsUnknownErrors() {
        let unknownCode = NSError(domain: domain, code: 99)
        #expect(LocationConfirmation(inRegion: false, error: unknownCode, payloadErrorDomain: domain) == .failed(domain: domain, code: 99))
        let otherDomain = NSError(domain: NSURLErrorDomain, code: 1)
        #expect(LocationConfirmation(inRegion: true, error: otherDomain, payloadErrorDomain: domain) == .failed(domain: NSURLErrorDomain, code: 1))
    }
}
