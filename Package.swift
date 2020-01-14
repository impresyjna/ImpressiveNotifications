// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ImpressiveNotifications",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "ImpressiveNotifications",
            targets: ["ImpressiveNotifications"]
        )
    ],
    targets: [
        .target(
            name: "ImpressiveNotifications",
            path: "ImpressiveNotifications/Sources"
        )
    ]
)

