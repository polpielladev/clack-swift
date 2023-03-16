// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Clack",
    products: [
        .library(name: "Clack", targets: ["Clack"])
    ],
    dependencies: [
        .package(url: "https://github.com/pakLebah/ANSITerminal.git", exact: "0.0.3")
    ],
    targets: [
        .target(
            name: "Clack",
            dependencies: ["ANSITerminal"]),
        .executableTarget(name: "ClackExample", dependencies: ["Clack"]),
        .testTarget(
            name: "ClackTests",
            dependencies: ["Clack"]),
    ]
)
