import Foundation

/*
struct MontereyDownloader: Downloading {
    func galleryDl(_ urls: [String]) async throws -> String {
        try await withCheckedContinuation { continuation in
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
            process.arguments = ["gallery-dl"] + urls
            
            let pipe = Pipe()
            process.standardOutput = pipe
            process.standardError = FileHandle.nullDevice
            
            process.terminationHandler { finishedProcess in
                let text = String() ?? ""
                continuation.resume(returning: "")
                
            }
            
            
            do {
                try process.run()
            } catch {
               
            }
        }
    }
}
*/
