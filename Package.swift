// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ImpressiveNotifications",
    platforms: [.iOS("11.0")],
    products: [
        .library(name: "ImpressiveNotifications", targets: ["ImpressiveNotifications"]),
    ],
    targets: [
        .target(name: "ImpressiveNotifications", dependencies: [], path: "ImpressiveNotifications/Sources")
    ]
)

