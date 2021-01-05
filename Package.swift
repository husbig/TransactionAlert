// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TransactionAlert",
    platforms: [
      .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TransactionAlert",
            targets: ["TransactionAlert"]),
    ],
    dependencies: [
        .package(url: "https://github.com/AndreaMiotto/PartialSheet", from: "2.1.11"),
        .package(name: "Lottie",url: "https://github.com/airbnb/lottie-ios", from: "3.1.9"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TransactionAlert",
            dependencies: ["Lottie","PartialSheet"],
            resources: [.process("Resources/taAnimation.json")]),
        .testTarget(
            name: "TransactionAlertTests",
            dependencies: ["TransactionAlert"]),
    ]
)
