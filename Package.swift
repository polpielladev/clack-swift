// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Clack",
    dependencies: [
        .package(url: "https://github.com/pakLebah/ANSITerminal.git", exact: "0.0.3")
    ],
    targets: [
        .executableTarget(
            name: "Clack",
            dependencies: ["ANSITerminal"]),
        .testTarget(
            name: "ClackTests",
            dependencies: ["Clack"]),
    ]
)
