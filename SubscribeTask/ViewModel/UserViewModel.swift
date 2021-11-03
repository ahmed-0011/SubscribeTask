//
//  SubscribeViewModel.swift
//  SubscribeTask
//
//  Created by ahmed on 25/10/2021.
//

import Foundation

struct UserViewModel {
  
    var message: String
    var name: String
    var email: String
    var isSubscribed: Bool?
    
    init(user: User?) {
        
        if user != nil {
            message = user?.isSubsicribed == true ? "SubscribedMessage".localized : "NotSubscribedMessage".localized
        } else {
            message = "WelcomeMessage".localized
        }
        name = "Name".localized + (user?.name ?? "")
        email = "Email".localized + (user?.email ?? "")
        isSubscribed = user?.isSubsicribed
    }
}
