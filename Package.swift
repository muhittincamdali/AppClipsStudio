// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "AppClipsStudio",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "AppClipsStudio", targets: ["AppClipsStudio"]),
        .executable(name: "appclipstudio", targets: ["appclipstudio"])
    ],
    targets: [
        .target(
            name: "AppClipsStudio",
            path: "Sources/AppClipsStudio"
        ),
        .target(
            name: "AppClipsStudioTool",
            dependencies: ["AppClipsStudio"],
            path: "Sources/AppClipsStudioTool"
        ),
        .executableTarget(
            name: "appclipstudio",
            dependencies: ["AppClipsStudioTool"],
            path: "Sources/appclipstudio"
        ),
        .testTarget(
            name: "AppClipsStudioTests",
            dependencies: ["AppClipsStudio"]
        ),
        .testTarget(
            name: "AppClipsStudioToolTests",
            dependencies: ["AppClipsStudioTool"]
        )
    ]
)
