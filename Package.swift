// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MomentSDK",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MomentCommon",
            targets: ["MomentCommon"]),
        .library(
            name: "MomentEditor",
            targets: ["MomentEditor"]),
        .library(
            name: "MomentPlayer",
            targets: ["MomentPlayer"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        
        // MARK: - Common
        
        .target(
            name: "MomentCommon",
            dependencies: ["MomentCommonUtil"],
            path: "Sources/Common/MomentCommon"),
        
        .target(
            name: "MomentCommonUtil",
            dependencies: [],
            path: "Sources/Common/Util"),
        
        // MARK: - Editor
        
        .target(
            name: "MomentEditor",
            dependencies: [
                "MomentEditorDomain", "MomentEditorView", "MomentEditorRepository"
            ],
            path: "Sources/Editor/MomentEditor"),
        .testTarget(
            name: "MomentEditorTests",
            dependencies: ["MomentEditor"],
            path: "Tests/Editor/MomentEditorTests"),
        .target(
            name: "MomentEditorDomain",
            dependencies: ["MomentCommonUtil"],
            path: "Sources/Editor/Domain"),
        .testTarget(
            name: "MomentEditorDomainTests",
            dependencies: ["MomentEditorDomain"],
            path: "Tests/Editor/DomainTests"),
        .target(
            name: "MomentEditorView",
            dependencies: ["MomentEditorDomain", "MomentCommonUtil"],
            path: "Sources/Editor/View"),
        .target(
            name: "MomentEditorRepository",
            dependencies: ["MomentEditorDomain", "Alamofire"],
            path: "Sources/Editor/Repository"),
        .testTarget(
            name: "MomentEditorRepositoryTests",
            dependencies: ["MomentEditorRepository"],
            path: "Tests/Editor/RepositoryTests"),
        
        // MARK: - Player
        
        .target(
            name: "MomentPlayer",
            dependencies: [
                "MomentPlayerDomain", "MomentPlayerView", "MomentPlayerRepository"
            ],
            path: "Sources/Player/MomentPlayer"),
        .testTarget(
            name: "MomentPlayerTests",
            dependencies: ["MomentPlayer"],
            path: "Tests/Player/MomentPlayerTests"),
        .target(
            name: "MomentPlayerDomain",
            dependencies: ["MomentCommonUtil"],
            path: "Sources/Player/Domain"),
        .testTarget(
            name: "MomentPlayerDomainTests",
            dependencies: ["MomentPlayerDomain"],
            path: "Tests/Player/DomainTests"),
        .target(
            name: "MomentPlayerView",
            dependencies: ["MomentPlayerDomain", "MomentCommonUtil"],
            path: "Sources/Player/View"),
        .target(
            name: "MomentPlayerRepository",
            dependencies: ["MomentPlayerDomain"],
            path: "Sources/Player/Repository"),
        .testTarget(
            name: "MomentPlayerRepositoryTests",
            dependencies: ["MomentPlayerRepository"],
            path: "Tests/Player/RepositoryTests"),
    ]
)
