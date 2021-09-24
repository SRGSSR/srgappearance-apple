// swift-tools-version:5.3

import PackageDescription

struct ProjectSettings {
    static let marketingVersion: String = "5.0.1"
}

let package = Package(
    name: "SRGAppearance",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "SRGAppearance",
            targets: ["SRGAppearance"]
        ),
        .library(
            name: "SRGAppearanceSwift",
            targets: ["SRGAppearanceSwift"]
        )
    ],
    targets: [
        .target(
            name: "SRGAppearance",
            resources: [
                .process("Fonts")
            ],
            cSettings: [
                .define("MARKETING_VERSION", to: "\"\(ProjectSettings.marketingVersion)\""),
                .define("NS_BLOCK_ASSERTIONS", to: "1", .when(configuration: .release))
            ]
        ),
        .target(
            name: "SRGAppearanceSwift",
            dependencies: ["SRGAppearance"]
        ),
        .testTarget(
            name: "SRGAppearanceTests",
            dependencies: ["SRGAppearance"],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "SRGAppearanceSwiftTests",
            dependencies: ["SRGAppearanceSwift"]
        )
    ]
)
