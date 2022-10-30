import Foundation
import PackagePlugin

@main
struct CargoBuildPlugin: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        let outputDir = context.pluginWorkDirectory.appending("GeneratedFiles")
        let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
        let cargoPath = Path(homeDirURL.path).appending([".cargo", "bin", "cargo"])
        let rustManifestPath = context.package.directory.appending(["ffi", "Cargo.toml"])

        return [
            .prebuildCommand(
                displayName: "Running Cargo",
                executable: cargoPath,
                arguments: [
                    "build",
                    "--manifest-path", rustManifestPath.description,
                    "--target-dir", outputDir.description,
                ],
                environment: [
                    "PATH": "/usr/bin"
                ],
                outputFilesDirectory: outputDir
            )
        ]
    }
}
