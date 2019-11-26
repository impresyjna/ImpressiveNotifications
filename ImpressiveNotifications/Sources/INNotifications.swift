//
//  INNotifications.swift
//  ImpressiveNotifications
//
//  Created by Asia Kasprzycka on 11/02/2019.
//  Copyright © 2019 Asia Kasprzycka. All rights reserved.
//

import UIKit
import CarPlay

public class INNotifications {
    
    static public func show(type: INNotificationType, data: INNotificationData? = nil, customStyle: INNotificationStyle? = nil, position: INNotificationPosition = .top) {
        let notificationView = INNotification(with: data ?? INNotificationData(), type: type, customStyle: customStyle, position: position)
        
        let windowView: UIWindow?
        if #available(iOS 12.0, *) {
            windowView = UIApplication.shared.windows.first(where: { !($0 is CPWindow) })
        } else {
            windowView = UIApplication.shared.keyWindow
        }
        
        guard let unwrappedWindow = windowView else {
            print("Failed to show. No window available")
            return
        }
        
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        unwrappedWindow.addSubview(notificationView)
        
        let verticalMargin = customStyle?.verticalMargin ?? 16.0
        let horizontalMargin = customStyle?.horizontalMargin ?? 16.0
        
        var constraints = [
            NSLayoutConstraint(item: notificationView , attribute: .leading, relatedBy: .equal, toItem: unwrappedWindow, attribute: .leadingMargin, multiplier: 1.0, constant: verticalMargin),
            NSLayoutConstraint(item: notificationView , attribute: .trailing, relatedBy: .equal, toItem: unwrappedWindow, attribute: .trailingMargin, multiplier: 1.0, constant: -1*verticalMargin)
        ]
        
            switch position {
            case .top:
                constraints.append(NSLayoutConstraint(item: notificationView , attribute: .top, relatedBy: .equal, toItem: unwrappedWindow, attribute: .topMargin, multiplier: 1.0, constant: horizontalMargin))
            case .bottom:
            constraints.append(NSLayoutConstraint(item: notificationView , attribute: .bottom, relatedBy: .equal, toItem: unwrappedWindow, attribute: .bottomMargin, multiplier: 1.0, constant: -1*horizontalMargin))
        }
        
        NSLayoutConstraint.activate(constraints)
        notificationView.showNotification()
    }
    
    static public func hide() {
        let windowView: UIWindow?
        if #available(iOS 12.0, *) {
            windowView = UIApplication.shared.windows.first(where: { !($0 is CPWindow) })
        } else {
            windowView = UIApplication.shared.keyWindow
        }
        
        guard let unwrappedWindow = windowView else {
            print("Failed to hide. No window available")
            return
        }

        if let notification =  unwrappedWindow.subviews.first(where: { $0 is INNotification }) as? INNotification {
            notification.hide()
        }
    }
}
