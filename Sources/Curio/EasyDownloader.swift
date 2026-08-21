import Subprocess

// @available(macOS 13, *)
struct EasyDownloader: Downloading {
    func galleryDl(_ urls: [String]) async throws -> String {
        
        // This is used in the Linux fallback
        // for sandboxed platforms like SteamOS
        let homebrewPath = "/opt/homebrew/bin"
        
        var platformPaths: [Environment.Key: String] {
#if os(macOS)
            ["PATH": ":\(homebrewPath):/usr/local/bin"]
#else
            ["PATH":":\(homebrewPath):/usr/bin:/bin"]
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
