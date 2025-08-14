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
        
        // Testing Utilities
        .library(
            name: "AppClipTesting",
            targets: ["AppClipTesting"]
        )
    ],
    dependencies: [
        // No external dependencies - Pure Swift implementation
    ],
    targets: [
        // MARK: - Core Framework
        .target(
            name: "AppClipsStudio",
            dependencies: [
                "AppClipCore",
                "AppClipRouter",
                "AppClipAnalytics",
                "AppClipUI",
                "AppClipNetworking",
                "AppClipStorage"
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
        
        // MARK: - Testing Support
        .target(
            name: "AppClipTesting",
            dependencies: [
                "AppClipsStudio",
                "AppClipCore"
            ],
            path: "Sources/AppClipTesting"
        ),
        
        // MARK: - Unit Tests
        .testTarget(
            name: "AppClipsStudioTests",
            dependencies: [
                "AppClipsStudio",
                "AppClipTesting"
            ],
            path: "Tests/UnitTests",
            resources: [
                .process("Resources")
            ]
        ),
        
        .testTarget(
            name: "AppClipCoreTests",
            dependencies: [
                "AppClipCore",
                "AppClipTesting"
            ],
            path: "Tests/UnitTests/AppClipCore"
        ),
        
        .testTarget(
            name: "AppClipRouterTests",
            dependencies: [
                "AppClipRouter",
                "AppClipTesting"
            ],
            path: "Tests/UnitTests/AppClipRouter"
        ),
        
        .testTarget(
            name: "AppClipAnalyticsTests",
            dependencies: [
                "AppClipAnalytics",
                "AppClipTesting"
            ],
            path: "Tests/UnitTests/AppClipAnalytics"
        ),
        
        .testTarget(
            name: "AppClipUITests",
            dependencies: [
                "AppClipUI",
                "AppClipTesting"
            ],
            path: "Tests/UnitTests/AppClipUI"
        ),
        
        .testTarget(
            name: "AppClipNetworkingTests",
            dependencies: [
                "AppClipNetworking",
                "AppClipTesting"
            ],
            path: "Tests/UnitTests/AppClipNetworking"
        ),
        
        .testTarget(
            name: "AppClipStorageTests",
            dependencies: [
                "AppClipStorage",
                "AppClipTesting"
            ],
            path: "Tests/UnitTests/AppClipStorage"
        ),
        
        // MARK: - Integration Tests
        .testTarget(
            name: "IntegrationTests",
            dependencies: [
                "AppClipsStudio",
                "AppClipTesting"
            ],
            path: "Tests/IntegrationTests",
            resources: [
                .process("Resources")
            ]
        ),
        
        // MARK: - Performance Tests
        .testTarget(
            name: "PerformanceTests",
            dependencies: [
                "AppClipsStudio",
                "AppClipTesting"
            ],
            path: "Tests/PerformanceTests"
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