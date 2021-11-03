//
//  SubscribeDetailView.swift
//  SubscribeTask
//
//  Created by ahmed on 01/11/2021.
//

import UIKit

protocol UserViewDelegate {
    func unsubscribe()
}

class UserView: UIView {
    
    var userViewModel: UserViewModel?
    var delegate: UserViewDelegate?
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var unsubscribeButton: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        viewInit()
    }
    
    func commonInit() {
        let view = Bundle(for: UserView.self).loadNibNamed("\(UserView.self)", owner: self)?.first as! UIView
        addSubview(view)
    }
    
    func viewInit() {
        labelsInit()
        buttonInit()
    }
    
    func labelsInit() {
        messageLabel.text = userViewModel?.message
        nameLabel.text = userViewModel?.name
        emailLabel.text = userViewModel?.email
        if let _ = userViewModel?.isSubscribed {
            nameLabel.isHidden = false
            emailLabel.isHidden = false
        } else {
            nameLabel.isHidden = true
            emailLabel.isHidden = true
        }
    }

    func buttonInit() {
        if let isSubsribed = userViewModel?.isSubscribed {
            if isSubsribed {
                unsubscribeButton.isHidden = false
            }
        } else {
            unsubscribeButton.isHidden = true
        }
    }
    
    @IBAction func onUnsubscribeClick(_ sender: Any) {
        delegate?.unsubscribe()
    }
}
