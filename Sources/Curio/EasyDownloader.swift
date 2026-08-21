import Subprocess

// @available(macOS 13, *)
struct EasyDownloader: Downloading {
    func galleryDl(_ urls: [String]) async throws -> String {
        
        // This two are also in the Linux fallback in order
        // to account for sandboxed environments like SteamOS
        let homebrewPath = "/opt/homebrew/bin"
        let localBin = "/usr/local/bin"
        
        var platformPaths: [Environment.Key: String] {
#if os(macOS)
            ["PATH": ":\(homebrewPath):\(localBin)"]
#else
            ["PATH":":\(homebrewPath):\(localBin):/usr/bin:/bin"]
#endif
        }
        
        let result = try await run(
            .name(cliProgram),
            arguments: Arguments(urls),
            environment: .inherit.updating(platformPaths),
            output: .string(limit: 1_048_576)
        )
        
        return result.standardOutput ?? ""
    }
}
