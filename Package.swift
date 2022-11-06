// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tokenizers",
    products: [
        .library(
            name: "Tokenizers",
            targets: ["Tokenizers"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Tokenizers",
            dependencies: ["TokenizersFFI"],
            linkerSettings: [
                .linkedLibrary("tokenizers")
            ]),
        .target(
            name: "TokenizersFFI",
            dependencies: []),
        .testTarget(
            name: "TokenizersTests",
            dependencies: ["Tokenizers"]),
    ]
)
