//
//  INNotificationDelegate.swift
//  ImpressiveNotifications
//
//  Created by Asia Kasprzycka on 18/03/2019.
//  Copyright © 2019 Asia Kasprzycka. All rights reserved.
//

import Foundation

public protocol INNotificationDelegate: class {
    func impressiveNotificationTapped()
    func impressiveNotificationFinished()
}

extension INNotificationDelegate {
    func impressiveNotificationTapped() {}
    func impressiveNotificationFinished() {}
}
