//
//  INNotificationPosition.swift
//  ImpressiveNotifications
//
//  Created by Radu Ursache on 27/02/2019.
//  Copyright © 2019 Radu Ursache. All rights reserved.
//

import UIKit

public enum INNotificationPosition {
    case top
    case bottom
    
    var hideDirection: INNotificationHideDirection {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        }
    }
}

public enum INNotificationHideDirection {
    case top
    case bottom
    case left
    case right
}
