//
//  SubscribeViewModel.swift
//  SubscribeTask
//
//  Created by ahmed on 25/10/2021.
//

import Foundation

struct UserViewModel {
  
    enum Mode {
        case subscribed, notsubscribed, requestFailed
    }
    
    var message: String
    var name: String
    var email: String
    var isSubscribeAlertBecomeActive: Bool
    var mode: Mode
    
    init(user: User?, mode: Mode, isSubscribeAlertBecomeActive: Bool = false) {
        self.mode = mode
        self.isSubscribeAlertBecomeActive = isSubscribeAlertBecomeActive
        if !isSubscribeAlertBecomeActive {
            switch mode {
            case .subscribed:
                message = "SubscribedMessage".localized
            case .notsubscribed:
                message = "NotSubscribedMessage".localized
            case .requestFailed:
                message = "RequestAuthorizationFailedMessage".localized
            }
        } else {
            message = "WelcomeMessage".localized
        }
        name = "Name".localized + (user?.name ?? "none".localized)
        email = "Email".localized + (user?.email ?? "none".localized)
    }
}
