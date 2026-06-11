// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppClipsStudio",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16),
        .visionOS(.v1)
    ],
    products: [
        // Core App Clips Studio Framework
        .library(
            name: "AppClipsStudio",
            targets: ["AppClipsStudio"]
        ),
        
        // App Clip Creation and Management
        .library(
            name: "AppClipCore",
            targets: ["AppClipCore"]
        ),
        
        // URL Handling and Deep Linking
        .library(
            name: "AppClipRouter",
            targets: ["AppClipRouter"]
        ),
        
        // Analytics and Performance
        .library(
            name: "AppClipAnalytics",
            targets: ["AppClipAnalytics"]
        ),
        
        // UI Components for App Clips
        .library(
            name: "AppClipUI",
            targets: ["AppClipUI"]
        ),
        
        // Networking for App Clips
        .library(
            name: "AppClipNetworking",
            targets: ["AppClipNetworking"]
        ),
        
        // Storage and Persistence
        .library(
            name: "AppClipStorage",
            targets: ["AppClipStorage"]
        ),
        
        // Security and Encryption
        .library(
            name: "AppClipSecurity",
            targets: ["AppClipSecurity"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0")
    ],
    targets: [
        // MARK: - CLI Tool
        .executableTarget(
            name: "appclipstudio",
            dependencies: [
                "AppClipCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/CLI"
        ),
        
        // MARK: - Core Framework
        .target(
            name: "AppClipsStudio",
            dependencies: [
                "AppClipCore",
                "AppClipRouter",
                "AppClipAnalytics",
                "AppClipUI",
                "AppClipNetworking",
                "AppClipStorage",
                "AppClipSecurity"
            ],
            path: "Sources/AppClipsStudio",
            resources: [
                .process("Resources")
            ]
        ),
        
        // MARK: - Core Components
        .target(
            name: "AppClipCore",
            dependencies: [],
            path: "Sources/AppClipCore",
            resources: [
                .process("Resources")
            ]
        ),
        
        .target(
            name: "AppClipRouter",
            dependencies: ["AppClipCore"],
            path: "Sources/AppClipRouter"
        ),
        
        .target(
            name: "AppClipAnalytics",
            dependencies: ["AppClipCore"],
            path: "Sources/AppClipAnalytics"
        ),
        
        .target(
            name: "AppClipUI",
            dependencies: ["AppClipCore"],
            path: "Sources/AppClipUI",
            resources: [
                .process("Resources")
            ]
        ),
        
        .target(
            name: "AppClipNetworking",
            dependencies: ["AppClipCore"],
            path: "Sources/AppClipNetworking"
        ),
        
        .target(
            name: "AppClipStorage",
            dependencies: ["AppClipCore"],
            path: "Sources/AppClipStorage"
        ),
        
        .target(
            name: "AppClipSecurity",
            dependencies: ["AppClipCore"],
            path: "Sources/AppClipSecurity"
        )
    ],
    swiftLanguageVersions: [.v5]
)

// MARK: - Conditional Dependencies for Different Platforms

#if os(iOS)
// iOS-specific configurations
#endif

#if os(macOS)
// macOS-specific configurations for App Clip development tools
#endif