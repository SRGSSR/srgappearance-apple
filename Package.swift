// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SRGAppearance",
    platforms: [
        .iOS(.v9),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "SRGAppearance",
            targets: ["SRGAppearance"]
        )
    ],
    targets: [
        .target(
            name: "SRGAppearance",
            resources: [
                .copy("Fonts")
            ]
        ),
        .testTarget(
            name: "SRGAppearanceTests",
            dependencies: ["SRGAppearance"],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
