// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Planar",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7),
        .tvOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Planar",
            targets: ["Planar"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/0xOpenBytes/Cache.git", from: "0.1.0"),
        .package(url: "https://github.com/0xOpenBytes/TaskManager", from: "0.1.0"),
        .package(url: "https://github.com/0xOpenBytes/Disk", from: "0.1.0"),
        .package(url: "https://github.com/0xLeif/Scribe", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Planar",
            dependencies: [
                "Cache",
                "TaskManager",
                "Disk",
                "Scribe"
            ]
        ),
        .testTarget(
            name: "PlanarTests",
            dependencies: ["Planar"]
        )
    ]
)
