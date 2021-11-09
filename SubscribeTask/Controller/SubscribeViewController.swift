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
    static let identifier = "SubscribeViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeView.delegate = self
    }
    
    func cancel(subscribeViewModel: SubscribeViewModel) {
        let notificationManager: NotificationManager = NotificationManager()
        notificationManager.requestAuthorization() { success in
            if !success {
                self.delegate?.requestAuthorizationFailed()
            }
        }
        postUserObject(nil)
    }
    
    func subscribe(subscribeViewModel: SubscribeViewModel) {
        let user = User(name: subscribeViewModel.name, email: subscribeViewModel.email)
        UserDefaultsManager.shared.saveUser(user: user)
        postUserObject(user)
    }
    
    func postUserObject(_ user: User?) {
        NotificationCenter.default.post(name: Notification.Name(SUBSCRIBE_ALERT_VIEW_CLOSED_NOTIFICATION), object: user)
        dismiss(animated: true)
    }
}
