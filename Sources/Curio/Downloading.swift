/// This protocol will allow backwards compatibility with macOS 12 and earlier
/// Subprocess only support 13 and later.
protocol Downloading {
    func galleryDl(_ args: [String]) async throws -> String
}
