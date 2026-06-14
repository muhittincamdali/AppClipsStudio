// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AppClipsStudio",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AppClipsStudio", targets: ["AppClipsStudio"]),
    ],
    targets: [
        .target(
            name: "AppClipsStudio",
            path: "Sources/AppClipsStudio",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "AppClipsStudioTests",
            dependencies: ["AppClipsStudio"]
        )
    ]
)
