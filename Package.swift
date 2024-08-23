// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "codeforge",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(
            name: "codeforge",
            targets: ["codeforge"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jkandzi/Progress.swift.git", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(name: "codeforge",
            dependencies: [
                .product(name: "Progress", package: "progress.swift")
            ]),
        .testTarget(
            name: "codeforgeTests",
            dependencies: ["codeforge"]),
    ]
)
