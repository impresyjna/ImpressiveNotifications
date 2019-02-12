//
//  INNotificationData.swift
//  ImpressiveNotifications
//
//  Created by Asia Kasprzycka on 11/02/2019.
//  Copyright © 2019 Asia Kasprzycka. All rights reserved.
//

import UIKit

public struct INNotificationData {
    let title: String
    let description: String?
    let image: UIImage?
    let delay: TimeInterval
    let completionHandler: (() -> Void)?
    
    public init(title: String = "", description: String? = nil, image: UIImage? = nil, delay: TimeInterval = 10.0, completionHandler: (() -> Void)? = nil) {
        self.title = title
        self.description = description
        self.image = image
        self.delay = delay
        self.completionHandler = completionHandler
    }
}
