// swift-tools-version:5.3

import PackageDescription

struct ProjectSettings {
    static let marketingVersion: String = "3.0.0"
}

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
            ],
            cSettings: [
                .define("MARKETING_VERSION", to: "\"\(ProjectSettings.marketingVersion)\"")
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
