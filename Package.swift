// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tokenizers",
    products: [
        .library(
            name: "Tokenizers",
            targets: ["Tokenizers", "TokenizersFFI"])
        // The "CargoBuild" plugin is used only within this package, so there is
        // no need to declare a `plugin` product.
        /*
        .plugin(
            name: "CargoBuild",
            targets: [
                "CargoBuild"
            ]
        ),
        */
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .plugin(
            name: "CargoBuild",
            capability: .buildTool()
        ),
        .target(
            name: "Tokenizers",
            dependencies: ["TokenizersFFI"],
            linkerSettings: [
                .linkedLibrary("tokenizers_ffi"),
                .unsafeFlags([
                    // TODO: Get the plugin path programmatically.
                    "-L.build/plugins/outputs/swift-tokenizers/TokenizersFFI/CargoBuild/GeneratedFiles/debug"
                ]),
            ]
        ),
        .target(
            name: "TokenizersFFI",
            dependencies: [],
            plugins: ["CargoBuild"]),
        .testTarget(
            name: "TokenizersTests",
            dependencies: ["Tokenizers"]),
    ]
)
