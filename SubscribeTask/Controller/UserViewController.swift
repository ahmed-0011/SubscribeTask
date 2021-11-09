//
//  UserViewController.swift
//  SubscribeTask
//
//  Created by ahmed on 24/10/2021.
//

import UIKit

class UserViewController: UIViewController {
 
    @IBOutlet var userView: UserView!
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        userView.delegate = self
        user = UserDefaultsManager.shared.retrieveUser()
        
        if user != nil {    // user has subscried (the alert will not become active)
            viewInit(.subscribed)
        } else {            // user has not subscribed yet (subscribe alert will become active when viewDidAppear is                          called)
            viewInit(.notsubscribed, isSubscribeAlertBecomeActive: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if user == nil {
            addSubscribeAlertViewObserver()
            showSubscribeAlert()
        }
    }
    
    func addSubscribeAlertViewObserver() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(forName: Notification.Name(SUBSCRIBE_ALERT_VIEW_CLOSED_NOTIFICATION), object: nil, queue: nil) { notification in
            self.user = notification.object as? User
            self.user != nil ? self.viewInit(.subscribed) : self.viewInit(.notsubscribed)
        }
    }
    
    func showSubscribeAlert() {
        if let subscribeViewController = storyboard?.instantiateViewController(withIdentifier: SubscribeViewController.identifier) as? SubscribeViewController {
            subscribeViewController.delegate = self
            present(subscribeViewController, animated: true)
        }
    }
    
    func viewInit(_ mode: UserViewModel.Mode, isSubscribeAlertBecomeActive: Bool = false) {
        let userViewModel =  isSubscribeAlertBecomeActive == false ? UserViewModel(user: user, mode: mode) : UserViewModel(user: user, mode: mode, isSubscribeAlertBecomeActive: true)
        userView.userViewModel = userViewModel
        userView.viewInit()
    }
}


// MARK: - User View Delegate
extension UserViewController: UserViewDelegate {
    
    func unsubscribe() {
          let unsubscribeAlert = UIAlertController(title: "UnsubscribeAlertTitle".localized, message: "UnsubscribeAlertMessage".localized, preferredStyle: .alert)
        
          unsubscribeAlert.addAction(UIAlertAction(title: "CancelButton".localized, style: .cancel))
          unsubscribeAlert.addAction(UIAlertAction(title: "ConfirmButton".localized, style: .destructive) { _ in
              
              let unsubscribedSuccessfullyAlert = UIAlertController(title: "UnsubscribedSuccessfullyAlertTitle".localized, message: "UnsubscribedSuccessfullyAlertMessage".localized, preferredStyle: .alert)
              unsubscribedSuccessfullyAlert.addAction(UIAlertAction(title: "OkButton".localized, style: .default) { _ in
                  self.addSubscribeAlertViewObserver()
                  self.showSubscribeAlert()
              })
              self.present(unsubscribedSuccessfullyAlert, animated: true)
              self.user = nil
              self.viewInit(.notsubscribed, isSubscribeAlertBecomeActive: true)
              UserDefaultsManager.shared.removeUser()
          })
          present(unsubscribeAlert, animated: true)
      }
    
    func subscribe() {
        viewInit(.notsubscribed, isSubscribeAlertBecomeActive: true)
        addSubscribeAlertViewObserver()
        showSubscribeAlert()
    }
}


// MARK: - Subscribe View Controller Delegate
extension UserViewController: SubscribeViewControllerDelegate {
    
    func requestAuthorizationFailed() {
        DispatchQueue.main.async {
            self.viewInit(.requestFailed)
            let requestAuthorizationFailedAlert = UIAlertController(
                title: "RequestAuthorizationFailedAlertTitle".localized,
                message: "RequestAuthorizationFailedAlertMessage".localized,
                preferredStyle: .alert
            )
            requestAuthorizationFailedAlert.addAction(UIAlertAction(title: "OkButton".localized, style: .default))
            self.present(requestAuthorizationFailedAlert, animated: true)
        }
    }
}
