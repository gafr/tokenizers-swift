// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tokenizers",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Tokenizers",
            targets: ["Tokenizers", "TokenizersFFI"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Tokenizers",
            dependencies: ["TokenizersFFI"],
            linkerSettings: [
                .linkedLibrary("tokenizers_ffi"),
                .unsafeFlags([
                    "-L./ffi/target/debug"
                ]),
            ]
        ),
        .target(name: "TokenizersFFI", dependencies: []),
        .testTarget(
            name: "TokenizersTests",
            dependencies: ["Tokenizers"]),
    ]
)
