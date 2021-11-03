//
//  SubscribeViewController.swift
//  SubscribeTask
//
//  Created by ahmed on 01/11/2021.
//

import UIKit

protocol SubscribeViewControllerDelegate {
    func requestAuthorizationFailed()
}

class SubscribeViewController: UIViewController, SubscribeViewDelegate {
   
    @IBOutlet var subscribeView: SubscribeView!
    var delegate: SubscribeViewControllerDelegate?
    var userDefaultsManager: UserDefaultsManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeView.delegate = self
    }
    
    func cancel(subscribeViewModel: SubscribeViewModel) {
        let user = User(name: subscribeViewModel.name, email: subscribeViewModel.email, isSubsicribed: false)
        userDefaultsManager?.saveUser(user: user)
        NotificationCenter.default.post(name: Notification.Name("SubscribeAlertViewClosed"), object: user)
        let notificationManager: NotificationManager = NotificationManager(userDefaultsManager: userDefaultsManager!)
        notificationManager.requestAuthorization() { success in
            if !success {
                self.delegate?.requestAuthorizationFailed()
            }
        }
        dismiss(animated: true)
    }
    
    func subscribe(subscribeViewModel: SubscribeViewModel) {
        let user = User(name: subscribeViewModel.name, email: subscribeViewModel.email, isSubsicribed: true)
        userDefaultsManager?.saveUser(user: user)
        NotificationCenter.default.post(name: Notification.Name("SubscribeAlertViewClosed"), object: user)
        dismiss(animated: true)
    }
}
