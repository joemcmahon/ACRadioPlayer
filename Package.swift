// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ACRadioPlayer",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "ACRadioPlayer",
            targets: ["ACRadioPlayer"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ACRadioPlayer",
            dependencies: []),
        .testTarget(
            name: "ACRadioPlayerTests",
            dependencies: ["ACRadioPlayer"]),
    ]
)
