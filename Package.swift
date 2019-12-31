//
//  Package.swift
//  ImpressiveNotifications
//
//  Created by Artyom Rudakov on 31.12.2019.
//  Copyright © 2019 Artyom Rudakov. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "ImpressiveNotifications",
    products: [
        .library(name: "ImpressiveNotifications", targets: ["ImpressiveNotifications"]),
    ],
    targets: [
        .target(name: "ImpressiveNotifications", dependencies: [], path: "ImpressiveNotifications/Sources")
    ]
)

