# App Clips Studio

<p align="center">
  <img src="Assets/banner.png" alt="App Clips Studio" width="800">
</p>

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-5.9+-F05138?style=flat&logo=swift&logoColor=white" alt="Swift"></a>
  <a href="https://developer.apple.com/ios/"><img src="https://img.shields.io/badge/iOS-16.0+-000000?style=flat&logo=apple&logoColor=white" alt="iOS"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License"></a>
</p>

<p align="center">
  <b>Build and deploy App Clips with ease. Lightweight, fast, and focused experiences.</b>
</p>

---

## What are App Clips?

App Clips are small, focused parts of your app that let users complete tasks quickly without downloading the full app. Users can discover them through:

- NFC tags
- QR codes
- App Clip Codes
- Safari Smart Banners
- Maps
- Messages

## Features

- **Quick Setup** — Templates for common App Clip scenarios
- **Size Optimized** — Stay under the 15MB limit
- **Invocation Handling** — Handle different invocation methods
- **Seamless Upgrade** — Convert App Clip users to full app users
- **Location Verification** — Verify user location for secure experiences

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/AppClipsStudio.git", from: "1.0.0")
]
```

## Quick Start

### 1. Create App Clip Target

In Xcode: File → New → Target → App Clip

### 2. Configure Info.plist

```xml
<key>NSAppClip</key>
<dict>
    <key>NSAppClipRequestLocationConfirmation</key>
    <true/>
</dict>
```

### 3. Handle Invocation

```swift
import SwiftUI
import AppClip

@main
struct MyAppClip: App {
    @State private var model = AppClipModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
                    guard let url = activity.webpageURL else { return }
                    model.handleInvocation(url: url)
                }
        }
    }
}

class AppClipModel: ObservableObject {
    @Published var productId: String?
    @Published var storeId: String?
    
    func handleInvocation(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        
        // Parse URL parameters
        // https://example.com/appclip?product=123&store=456
        productId = components.queryItems?.first(where: { $0.name == "product" })?.value
        storeId = components.queryItems?.first(where: { $0.name == "store" })?.value
    }
}
```

### 4. Location Verification

```swift
import AppClip
import CoreLocation

class LocationVerifier: ObservableObject {
    @Published var isVerified = false
    @Published var verificationError: Error?
    
    func verify(at region: CLCircularRegion) {
        let activity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
        
        activity.appClipActivationPayload?.confirmAcquired(in: region) { inRegion, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.verificationError = error
                    return
                }
                self.isVerified = inRegion
            }
        }
    }
}

// Usage
let storeLocation = CLCircularRegion(
    center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
    radius: 100,
    identifier: "store"
)
verifier.verify(at: storeLocation)
```

### 5. Promote Full App Download

```swift
import StoreKit

struct UpgradePromptView: View {
    @State private var showAppStore = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Get the Full Experience")
                .font(.headline)
            
            Text("Download the app for more features")
                .foregroundStyle(.secondary)
            
            Button("Download App") {
                showAppStore = true
            }
            .buttonStyle(.borderedProminent)
        }
        .appStoreOverlay(isPresented: $showAppStore) {
            SKOverlay.AppClipConfiguration(position: .bottom)
        }
    }
}
```

## App Clip Templates

### Order Ahead

```swift
struct OrderAheadClip: View {
    @EnvironmentObject var model: AppClipModel
    @StateObject private var cart = Cart()
    
    var body: some View {
        NavigationStack {
            if let productId = model.productId {
                ProductOrderView(productId: productId, cart: cart)
            } else {
                MenuView(cart: cart)
            }
        }
    }
}
```

### Parking Payment

```swift
struct ParkingClip: View {
    @EnvironmentObject var model: AppClipModel
    @State private var duration: TimeInterval = 3600
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Parking Zone \(model.storeId ?? "Unknown")")
                .font(.title)
            
            DurationPicker(duration: $duration)
            
            PaymentButton(amount: calculatePrice(duration))
        }
        .padding()
    }
}
```

### Bike Rental

```swift
struct BikeRentalClip: View {
    @EnvironmentObject var model: AppClipModel
    @StateObject private var locationVerifier = LocationVerifier()
    
    var body: some View {
        Group {
            if locationVerifier.isVerified {
                UnlockBikeView(bikeId: model.productId)
            } else {
                VerifyingLocationView()
            }
        }
        .onAppear {
            verifyLocation()
        }
    }
}
```

## Size Optimization

Keep your App Clip under 15MB:

```swift
// 1. Use SF Symbols instead of custom images
Image(systemName: "cart.fill")

// 2. Lazy load images
AsyncImage(url: imageURL) { image in
    image.resizable()
} placeholder: {
    ProgressView()
}

// 3. Remove unused code and assets
// Check build report in Xcode

// 4. Use on-demand resources for large assets
// Or fetch from server
```

## Project Structure

```
AppClipsStudio/
├── Sources/
│   ├── Core/
│   │   ├── AppClipModel.swift
│   │   └── LocationVerifier.swift
│   ├── Templates/
│   │   ├── OrderAhead/
│   │   ├── Parking/
│   │   └── Rental/
│   └── Utils/
├── Examples/
└── Tests/
```

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Documentation

- [Getting Started](Documentation/GettingStarted.md)
- [Invocation URLs](Documentation/InvocationURLs.md)
- [Location Verification](Documentation/LocationVerification.md)
- [Size Optimization](Documentation/SizeOptimization.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE).

## Author

**Muhittin Camdali** — [@muhittincamdali](https://github.com/muhittincamdali)

---

<p align="center">
  <sub>Instant experiences, no download required ❤️</sub>
</p>
