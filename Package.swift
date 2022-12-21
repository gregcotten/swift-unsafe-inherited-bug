// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-unsafe-inherited",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "swift-unsafe-inherited",
            targets: ["swift-unsafe-inherited"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "swift-unsafe-inherited",
            dependencies: []),
        .testTarget(
            name: "swift-unsafe-inheritedTests",
            dependencies: ["swift-unsafe-inherited"]),
    ]
)
