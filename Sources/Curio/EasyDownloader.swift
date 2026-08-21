import Subprocess

// @available(macOS 13, *)
struct EasyDownloader: Downloading {
    func galleryDl(_ urls: [String]) async throws -> String {
        let result = try await run(
            .name(cliProgram),
            arguments: Arguments(urls),
            output: .string(limit: 1_048_576)
        )
        
        return result.standardOutput ?? ""
    }
}
