// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "ios-featuremanagement",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "FeatureManagementModule",
            targets: ["FeatureManagementModule"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ivalx1s/darwin-relux.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(
            name: "FeatureManagementModule",
            dependencies: [
                .product(name: "Relux", package: "darwin-relux")
            ],
            path: "Sources"
        ),
    ]
)

