//
//  ViewController.swift
//  SubscribeTask
//
//  Created by ahmed on 24/10/2021.
//

import UIKit
import PMAlertController

class SubscribeViewController: UIViewController {

    @IBOutlet var subscribeView: SubscribeView!
    var subscribeViewModel: SubscribeViewModel?
    let userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        user = userDefaultsManager.retrieveUser()
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if user == nil {
            showAlert()
        }
    }
    
    func initView() {
        subscribeViewModel = SubscribeViewModel(user: user)
        subscribeView.subscribeViewModel = subscribeViewModel
        subscribeView.initView()
    }
    
    func showAlert() {
        let alert = PMAlertController(title: "Subscribe!", description: "Do you want to subscribe?", image: UIImage(named: "subscribe"), style: .alert)

        alert.addTextField { textField in
            textField?.placeholder = "Enter your name"
            textField?.becomeFirstResponder()
        }
        alert.addTextField { textField in
            textField?.placeholder = "Enter your email"
            textField?.keyboardType = .emailAddress
        }
        alert.addAction(PMAlertAction(title: "Subscribe", style: .default, action: ({
            self.subscribe(name: alert.textFields[0].text, email: alert.textFields[1].text)
        })))
        alert.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: ({
            self.cancel(name: alert.textFields[0].text, email: alert.textFields[1].text)
        })))
        
        alert.dismissWithBackgroudTouch = false
        present(alert, animated: true, completion: nil)
    }
    
    func subscribe(name: String?, email: String?) {
        user = User(name: name, email: email, isSubsicribed: true)
        userDefaultsManager.saveUser(user: user!)
        initView()
    }
    
    func cancel(name: String?, email: String?) {
        user = User(name:nil, email: nil, isSubsicribed: false)
        userDefaultsManager.saveUser(user: user!)
        initView()
       
        let notificationManager: NotificationManager = NotificationManager(userDefaultsManager: userDefaultsManager)
        notificationManager.requestAuthorization()
    }
}
