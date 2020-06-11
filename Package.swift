// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "InukBlog",
    products: [
        .executable(
            name: "InukBlog",
            targets: ["InukBlog"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.6.0"),
        .package(name: "Plot", url: "https://github.com/johnsundell/plot.git", from: "0.1.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0"),
        .package(name: "TwitterPublishPlugin", url: "https://github.com/insidegui/TwitterPublishPlugin", .branch("master"))
    ],
    targets: [
        .target(
            name: "InukBlog",
            dependencies: ["Publish",
                           "InukTheme",
                           "SplashPublishPlugin",
                           "TwitterPublishPlugin"]
        ),
        .target(
            name: "InukTheme",
            dependencies: ["Publish","Plot"]
        )
    ]
)
