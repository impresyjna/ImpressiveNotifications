//
//  INNotifications.swift
//  ImpressiveNotifications
//
//  Created by Asia Kasprzycka on 11/02/2019.
//  Copyright © 2019 Asia Kasprzycka. All rights reserved.
//

import UIKit

public class INNotifications {
    
    static public func show(type: INNotificationType, data: INNotificationData? = nil, customStyle: INNotificationStyle? = nil, position: INNotificationPosition? = nil) {
        let notificationView = INNotification(with: data ?? INNotificationData(), type: type, customStyle: customStyle)
        
        guard let window = UIApplication.shared.keyWindow else {
            print("Failed to show. No window available")
            return
        }
        
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(notificationView)
        
        var constraints = [
            NSLayoutConstraint(item: notificationView , attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leadingMargin, multiplier: 1.0, constant: 16.0),
            NSLayoutConstraint(item: notificationView , attribute: .trailing, relatedBy: .equal, toItem: window, attribute: .trailingMargin, multiplier: 1.0, constant: -16.0)
        ]
        
        if let position = position {
            switch position {
            case .top:
                constraints.append(NSLayoutConstraint(item: notificationView , attribute: .top, relatedBy: .equal, toItem: window, attribute: .topMargin, multiplier: 1.0, constant: 16.0))
            case .bottom:
                constraints.append(NSLayoutConstraint(item: notificationView , attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottomMargin, multiplier: 1.0, constant: 16.0))
            }
        }
        
        NSLayoutConstraint.activate(constraints)
        notificationView.showNotification()
    }
}
