// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "DynamicIslandMock",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "DynamicIslandMock",
            targets: ["DynamicIslandMock"]
        )
    ],
    targets: [
        .target(
            name: "DynamicIslandMock"
        ),
        .testTarget(
            name: "DynamicIslandMockTests",
            dependencies: ["DynamicIslandMock"]
        )
    ]
)
