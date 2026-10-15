// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "AppClipsStudio",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "AppClipsStudio", targets: ["AppClipsStudio"])
    ],
    targets: [
        .target(
            name: "AppClipsStudio",
            path: "Sources/AppClipsStudio"
        ),
        .testTarget(
            name: "AppClipsStudioTests",
            dependencies: ["AppClipsStudio"]
        )
    ]
)
