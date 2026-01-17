// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "relux-connectionmonitor",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ConnectionMonitor",
            targets: ["ConnectionMonitor"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ivalx1s/darwin-relux.git", .upToNextMajor(from: "8.4.0"))
    ],
    targets: [
        .target(
            name: "ConnectionMonitor",
            dependencies: [
                .product(name: "Relux", package: "darwin-relux")
            ],
            path: "Sources"
        ),
    ]
)

