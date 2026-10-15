# Handing Off to the Full App

Confirm where the App Clip was invoked, recommend the full app, and carry the App Clip's data
over when the full app replaces it.

## Overview

An App Clip is used once, in a place, for a task. Three things make that moment work: knowing
the person is really at the table or store the code belongs to, offering the full app after the
task is done, and making sure nothing is lost when they install it.

### Confirm the location

For App Clips invoked from NFC tags or visual codes, the system can confirm that the person is
inside a region you expect, without asking for location access. Set
`NSAppClipRequestLocationConfirmation` to `true` in the `NSAppClip` dictionary of the App Clip's
`Info.plist`, then pass the activation payload and an ``ExpectedLocation``:

```swift
.onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
    guard let payload = activity.appClipActivationPayload else { return }
    Task {
        let store = try ExpectedLocation(latitude: 41.0255, longitude: 28.9744, radius: 150, identifier: "store-1")
        switch await payload.confirm(store) {
        case .confirmed: showTableOrdering()
        case .notInRegion, .urlNotRegistered: showPickupOrdering()
        case .unavailable, .failed: showPickupOrdering()
        }
    }
}
```

Apple accepts a radius of up to 500 meters. ``ExpectedLocation`` rejects a radius that is not
greater than 0 and at most 500, coordinates out of range, and NaN or infinite values, also when
it is decoded from JSON. ``LocationConfirmation/unavailable`` covers both a person who turned
location confirmation off and an invocation that didn't come from a tag or code.

### Recommend the full app

After the task is done, show the App Store overlay for the full app:

```swift
OrderConfirmation()
    .fullAppOverlay(isPresented: $showsOverlay)
```

### Hand data to the full app

When the full app is installed, it replaces the App Clip. Apple recommends storing what the App
Clip collected in an App Group that both targets share. Add the same App Group to both targets,
then use a ``HandoffStore``:

```swift
struct PlacedOrder: Codable, Sendable {
    var drinkIDs: [Int]
}

let handoff = HandoffStore<PlacedOrder>(appGroup: "group.com.example.shop", key: "order")

// In the App Clip, after the order:
try handoff?.save(PlacedOrder(drinkIDs: [2, 3]), expiresAfter: 30 * 24 * 60 * 60)

// In the full app, on launch:
if let order = try handoff?.take() {
    showWelcomeBack(order)
}
```

``HandoffStore/take()`` returns the value once and removes it. Each value carries a schema
version, so after an incompatible change to the type a full app with a new version throws
``HandoffError/schemaMismatch(stored:expected:)`` instead of decoding the old data wrongly. Values
over 64 KB are refused on save and on load, before decoding.

Don't store passwords or tokens in the App Group. Apple recommends an anonymized identifier,
the keychain (from iOS 15.4, items the App Clip stores are available to the full app) or Sign
in with Apple.
