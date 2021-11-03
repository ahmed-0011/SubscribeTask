//
//  UserViewController.swift
//  SubscribeTask
//
//  Created by ahmed on 24/10/2021.
//

import UIKit

class UserViewController: UIViewController, UserViewDelegate, SubscribeViewControllerDelegate {
 
    @IBOutlet var userView: UserView!
    let userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        userView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = userDefaultsManager.retrieveUser()
        viewInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if user == nil {
            NotificationCenter.default.addObserver(forName: Notification.Name("SubscribeAlertViewClosed"), object: nil, queue: nil) { notification in
                self.user = notification.object as? User
                self.viewInit()
            }
            if let subscribeViewController = storyboard?.instantiateViewController(withIdentifier: "SubscribeViewController") as? SubscribeViewController {
                subscribeViewController.delegate = self
                subscribeViewController.userDefaultsManager = userDefaultsManager
                present(subscribeViewController, animated: true)
            }
        }
    }
    
    func viewInit() {
        let userViewModel = UserViewModel(user: user)
        userView.userViewModel = userViewModel
        userView.viewInit()
    }
  
    func unsubscribe() {

        let unsubscribeAlert = UIAlertController(title: "UnsubscribeAlertTitle".localized, message: "UnsubscribeAlertMessage".localized, preferredStyle: .alert)
        unsubscribeAlert.addAction(UIAlertAction(title: "CancelButton".localized, style: .cancel))
        unsubscribeAlert.addAction(UIAlertAction(title: "ConfirmButton".localized, style: .destructive) { _ in
            let confirmAlert = UIAlertController(title: "ConfirmAlertTitle".localized, message: "ConfirmAlertMessage".localized, preferredStyle: .alert)
            confirmAlert.addAction(UIAlertAction(title: "OkButton".localized, style: .default))
            self.present(confirmAlert, animated: true)
            self.user = nil
            self.viewInit()
            self.userDefaultsManager.removeUser()
        })
        present(unsubscribeAlert, animated: true)
    }
    
    func requestAuthorizationFailed() {
        
        userDefaultsManager.removeUser()
        var userViewModel = UserViewModel(user: User(name: "none".localized, email: "none".localized, isSubsicribed: false))
        userViewModel.message = "RequestAuthorizationFailedMessage".localized
        DispatchQueue.main.async {
            self.userView.userViewModel = userViewModel
            self.userView.viewInit()
            
            let requestAuthorizationFailedAlert = UIAlertController(title: "RequestAuthorizationFailedAlertTitle".localized, message: "RequestAuthorizationFailedAlertMessage".localized, preferredStyle: .alert)
            requestAuthorizationFailedAlert.addAction(UIAlertAction(title: "OkButton".localized, style: .default))
            self.present(requestAuthorizationFailedAlert, animated: true)
        }
    }
}
