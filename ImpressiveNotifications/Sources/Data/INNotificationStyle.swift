//
//  INNotificationStyle.swift
//  ImpressiveNotifications
//
//  Created by Asia Kasprzycka on 11/02/2019.
//  Copyright © 2019 Asia Kasprzycka. All rights reserved.
//

import UIKit

public struct INNotificationStyle {
    let cornerRadius: CGFloat?
    let backgroundColor: UIColor?
    let titleColor: UIColor?
    let descriptionColor: UIColor?
    let imageSize: CGSize?
    
    public init(cornerRadius: CGFloat? = nil,
         backgroundColor: UIColor? = nil,
         titleColor: UIColor? = nil,
         descriptionColor: UIColor? = nil,
         imageSize: CGSize? = nil) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
        self.imageSize = imageSize
    }
}
