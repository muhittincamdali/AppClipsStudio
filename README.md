<div align="center">

# 📱 AppClipsStudio

**Complete App Clips development toolkit for iOS with instant experiences**

[![Swift](https://img.shields.io/badge/Swift-5.9+-F05138?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/SPM-Compatible-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

</div>

---

## ✨ Features

- ⚡ **Instant Launch** — < 10MB optimized clips
- 🔗 **Universal Links** — Smart app banners
- 🎨 **Templates** — Ready-to-use clip designs
- 📍 **Location** — NFC & QR code triggers
- 🔐 **Sign in with Apple** — Streamlined auth

---

## 🚀 Quick Start

```swift
import AppClipsStudio

@main
struct MyAppClip: App {
    @StateObject var clipManager = AppClipManager()
    
    var body: some Scene {
        WindowGroup {
            AppClipView()
                .onAppear {
                    clipManager.handleInvocation()
                }
        }
    }
}

// Handle invocation URL
clipManager.handle(url) { location in
    // Show relevant content
}
```

---

## 📄 License

MIT • [@muhittincamdali](https://github.com/muhittincamdali)
