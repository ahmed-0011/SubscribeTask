//
//  SubscribeViewModel.swift
//  SubscribeTask
//
//  Created by ahmed on 03/11/2021.
//

import Foundation

struct SubscribeViewModel {
    
    var name: String
    var email: String
    
    func isNameValid() -> Bool {
        let format = "SELF MATCHES %@"
        let regex = "[a-zA-Z ]+"
        return NSPredicate(format:format ,regex).evaluate(with: name) && name.count >= 6
    }
    
    func isEmailValid() -> Bool {
        let format = "SELF MATCHES %@"
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format:format ,regex).evaluate(with: email)
    }
    
    mutating func setDataNone() {
        name = "none".localized
        email = "none".localized
    }
}
