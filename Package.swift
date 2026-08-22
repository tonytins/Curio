// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Curio",
    platforms: [.macOS(.v13), .iOS(.v13), .tvOS(.v13), .macCatalyst(.v13)],
    dependencies: [
        .package(
            url: "https://github.com/moreSwift/swift-cross-ui",
            .upToNextMinor(from: "0.7.0"),
        ),
        .package(
            url: "https://github.com/swiftlang/swift-subprocess.git",
            .upToNextMinor(from: "0.4.0"),
        ),
    ],
    targets: [
        .executableTarget(
            name: "Curio",
            dependencies: [
                .product(name: "SwiftCrossUI", package: "swift-cross-ui"),
                .product(name: "DefaultBackend", package: "swift-cross-ui"),
                .product(name: "Subprocess", package: "swift-subprocess"),
            ],
        ),
    ],
)
