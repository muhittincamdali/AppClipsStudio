<h1 align="center">AppClipsStudio</h1>

<p align="center">
  <strong>📱 Complete App Clips development toolkit for iOS with instant experiences</strong>
</p>

<p align="center">
  <a href="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml">
    <img src="https://github.com/muhittincamdali/AppClipsStudio/actions/workflows/ci.yml/badge.svg" alt="CI Status"/>
  </a>
  <img src="https://img.shields.io/badge/Swift-6.0-FA7343?style=for-the-badge&logo=swift&logoColor=white" alt="Swift 6.0"/>
  <img src="https://img.shields.io/badge/iOS-17.0+-000000?style=for-the-badge&logo=apple&logoColor=white" alt="iOS 17.0+"/>
  <img src="https://img.shields.io/badge/App_Clips-Ready-007AFF?style=for-the-badge&logo=apple&logoColor=white" alt="App Clips"/>
  <img src="https://img.shields.io/badge/SPM-Compatible-FA7343?style=for-the-badge&logo=swift&logoColor=white" alt="SPM"/>
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License"/>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#quick-start">Quick Start</a> •
  <a href="#components">Components</a> •
  <a href="#documentation">Documentation</a>
</p>

---

## 📋 Table of Contents

- [Why AppClipsStudio?](#why-appclipsstudio)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
  - [CocoaPods](#cocoapods)
- [Quick Start](#quick-start)
  - [Create App Clip Target](#1-create-app-clip-target)
  - [Define Experiences](#2-define-experiences)
  - [Configure Invocations](#3-configure-invocations)
- [Components](#components)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)
- [Star History](#-star-history)

---

## Why AppClipsStudio?

Building App Clips requires managing invocation URLs, handling deep links, creating lightweight experiences, and ensuring <10MB size. **AppClipsStudio** handles all the complexity.

```swift
// Define your App Clip in seconds
@main
struct MyAppClip: AppClip {
    var body: some Scene {
        AppClipScene { invocation in
            switch invocation.experience {
            case .orderFood(let restaurantId):
                OrderView(restaurant: restaurantId)
            case .rentBike(let stationId):
                BikeRentalView(station: stationId)
            }
        }
    }
}
```

## Features

| Feature | Description |
|---------|-------------|
| 🚀 **Quick Setup** | App Clip target in minutes |
| 🔗 **Smart Invocations** | NFC, QR, Safari, Maps, Messages |
| 📍 **Location Verification** | Confirm user is at location |
| 💳 **Apple Pay Ready** | One-tap payments |
| 🔐 **Sign in with Apple** | Seamless authentication |
| 📦 **Size Optimizer** | Keep under 10MB limit |
| 🧪 **Testing Tools** | Local & TestFlight testing |
| 📊 **Analytics** | Clip performance metrics |

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/AppClipsStudio.git", from: "1.0.0")
]
```

## Quick Start

### 1. Create App Clip Target

```bash
# Using CLI
appclipstudio init --name "MyAppClip" --bundleId "com.myapp.clip"
```

Or in Xcode: File → New → Target → App Clip

### 2. Define Experiences

```swift
import AppClipsStudio

enum ClipExperience: AppClipExperience {
    case orderFood(restaurantId: String)
    case viewMenu(restaurantId: String)
    case payBill(tableId: String)
    
    static func parse(from url: URL) -> ClipExperience? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        switch components.path {
        case "/order":
            return .orderFood(restaurantId: components.queryValue("id") ?? "")
        case "/menu":
            return .viewMenu(restaurantId: components.queryValue("id") ?? "")
        case "/pay":
            return .payBill(tableId: components.queryValue("table") ?? "")
        default:
            return nil
        }
    }
}
```

### 3. Build Your UI

```swift
struct OrderView: View {
    let restaurantId: String
    @StateObject private var viewModel = OrderViewModel()
    
    var body: some View {
        VStack {
            RestaurantHeader(id: restaurantId)
            MenuList(items: viewModel.menuItems)
            
            AppClipPayButton(amount: viewModel.total) {
                await viewModel.checkout()
            }
        }
        .appClipOverlay() // Shows "Get the Full App" banner
    }
}
```

## Invocation Methods

### NFC Tags

```swift
// Generate NFC payload
let nfcData = AppClipNFC.generate(
    url: "https://myapp.com/order?id=123",
    experience: .orderFood
)

// Write to NFC tag
try await NFCWriter.write(nfcData, to: tag)
```

### QR Codes

```swift
// Generate App Clip QR code
let qrCode = AppClipQR.generate(
    url: "https://myapp.com/menu?id=456",
    size: CGSize(width: 200, height: 200),
    style: .appClipCode // Special Apple design
)

Image(uiImage: qrCode)
```

### App Clip Codes

```swift
// Generate official App Clip Code
let clipCode = try await AppClipCode.request(
    url: "https://myapp.com/experience",
    style: .camera, // or .nfc
    color: .blue
)
```

### Safari Smart Banner

```html
<meta name="apple-itunes-app" 
      content="app-id=123456789, 
               app-clip-bundle-id=com.myapp.clip,
               app-clip-display=card">
```

### Maps Integration

```swift
// Register location-based experience
AppClipLocation.register(
    experience: .orderFood,
    coordinate: CLLocationCoordinate2D(latitude: 37.33, longitude: -122.03),
    radius: 100 // meters
)
```

## Components

### AppClipPayButton

One-tap Apple Pay:

```swift
AppClipPayButton(
    amount: 29.99,
    currency: .usd,
    label: "Order Coffee"
) { result in
    switch result {
    case .success(let payment):
        await processPayment(payment)
    case .failure(let error):
        showError(error)
    }
}
```

### AppClipSignInButton

Seamless authentication:

```swift
AppClipSignInButton { result in
    switch result {
    case .success(let credential):
        await createAccount(credential)
    case .failure(let error):
        showError(error)
    }
}
```

### LocationVerification

Confirm user location:

```swift
LocationVerification(
    coordinate: restaurantLocation,
    radius: 50
) { verified in
    if verified {
        showOrderOptions()
    } else {
        showLocationError()
    }
}
```

### AppClipOverlay

Promote full app:

```swift
ContentView()
    .appClipOverlay(
        title: "Get the Full Experience",
        subtitle: "Download MyApp for rewards & history",
        action: .openAppStore
    )
```

## Size Optimization

App Clips must be under 10MB. AppClipsStudio helps:

```swift
// Analyze bundle size
let analysis = try await BundleAnalyzer.analyze()
print("Current size: \(analysis.totalSize)")
print("Limit: 10MB")

for item in analysis.largestAssets {
    print("\(item.name): \(item.size)")
}

// Recommendations
for suggestion in analysis.optimizations {
    print(suggestion)
}
```

### Automatic Optimizations

```swift
AppClipOptimizer.configure {
    $0.compressImages = true
    $0.stripUnusedCode = true
    $0.minimizeAssets = true
    $0.useThinBinary = true
}
```

## Testing

### Local Testing

```swift
// Test invocation locally
AppClipTester.simulate(
    url: "https://myapp.com/order?id=test123",
    location: .mock(latitude: 37.33, longitude: -122.03)
)
```

### TestFlight

```swift
// Configure for TestFlight
AppClipConfig.testFlight {
    $0.invocationURL = "https://myapp.com/test"
    $0.mockLocation = true
}
```

### Xcode

```bash
# Run with invocation URL
appclipstudio run --url "https://myapp.com/order?id=123"
```

## Analytics

```swift
// Track clip performance
AppClipAnalytics.track(.clipLaunched(experience: .orderFood))
AppClipAnalytics.track(.paymentCompleted(amount: 29.99))
AppClipAnalytics.track(.fullAppPromoted)

// Get insights
let metrics = await AppClipAnalytics.getMetrics()
print("Launches: \(metrics.launches)")
print("Conversions: \(metrics.fullAppInstalls)")
print("Revenue: \(metrics.totalRevenue)")
```

## Data Transfer

Transfer data to full app:

```swift
// In App Clip
AppClipDataTransfer.save(
    key: "orderHistory",
    value: orderData
)

// In Full App
if let data = AppClipDataTransfer.retrieve(key: "orderHistory") {
    importOrderHistory(data)
}
```

## Best Practices

### Keep It Focused

```swift
// ✅ Good: Single focused task
struct BikeRentalClip: AppClip {
    var body: some Scene {
        AppClipScene { _ in
            RentBikeFlow() // Just rental, nothing else
        }
    }
}

// ❌ Avoid: Too many features
```

### Fast Launch

```swift
// ✅ Good: Immediate content
struct QuickOrderClip: View {
    var body: some View {
        MenuView() // Shows immediately
            .task {
                await loadDetails() // Background
            }
    }
}
```

### Clear Value

```swift
// Show value proposition immediately
SplashView(
    title: "Order in 30 Seconds",
    subtitle: "No app download required",
    action: "Start Order"
)
```

## CLI Tool

```bash
# Initialize App Clip target
appclipstudio init

# Analyze bundle size
appclipstudio analyze

# Generate QR codes
appclipstudio qr --url "https://myapp.com/exp" --output qr.png

# Test invocation
appclipstudio test --url "https://myapp.com/order"

# Validate configuration
appclipstudio validate
```

## Examples

See [Examples](Examples/):

- **CoffeeShop** - Order & pay
- **BikeRental** - Rent bikes
- **Restaurant** - View menu & pay bill
- **Parking** - Pay for parking

## Requirements

| Platform | Version |
|----------|---------|
| iOS | 17.0+ |
| Xcode | 16.0+ |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License - see [LICENSE](LICENSE).

---

<p align="center">
  <sub>Build instant experiences ⚡</sub>
</p>

---

## 📈 Star History

<a href="https://star-history.com/#muhittincamdali/AppClipsStudio&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=muhittincamdali/AppClipsStudio&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=muhittincamdali/AppClipsStudio&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=muhittincamdali/AppClipsStudio&type=Date" />
 </picture>
</a>
