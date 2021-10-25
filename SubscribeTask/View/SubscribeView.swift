//
//  SubscribeView.swift
//  SubscribeTask
//
//  Created by ahmed on 24/10/2021.
//

import UIKit

class SubscribeView: UIView {

    var subscribeViewModel: SubscribeViewModel?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        initLabels()
        initButton()
    }
    
    func initLabels() {
        
        if subscribeViewModel?.user != nil {
        
            if subscribeViewModel?.user?.isSubsicribed == true {
            label.text = "Thank you for the subscription"
                name.text?.append(subscribeViewModel?.user?.name ?? "")
                email.text?.append(subscribeViewModel?.user?.email ?? "")
            name.isHidden = false
            email.isHidden = false
        } else {
            label.text = "You're not subscribed yet!"
        }
        }
    }
    
    func initButton() {
        if subscribeViewModel?.user?.isSubsicribed == true {
            button.isHidden = false
        }
    }
  
    @IBAction func unsubscribe(_ sender: Any) {
        let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.removeUser()
    }
}
