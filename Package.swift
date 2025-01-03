// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ACRadioPlayer",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v15)
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
            dependencies: ["ACRadioPlayer"]),
        .testTarget(
            name: "ACRadioPlayerTests",
            dependencies: ["ACRadioPlayer"]),
    ]
)
