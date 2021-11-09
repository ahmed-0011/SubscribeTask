//
//  SubscribeDetailView.swift
//  SubscribeTask
//
//  Created by ahmed on 01/11/2021.
//

import UIKit

protocol UserViewDelegate {
    func subscribe()
    func unsubscribe()
}

class UserView: UIView {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var subscribeButton: UIButton!
    @IBOutlet var unsubscribeButton: UIButton!
    var userViewModel: UserViewModel?
    var delegate: UserViewDelegate?
    
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
        
        if userViewModel?.isSubscribeAlertBecomeActive == false {
            nameLabel.isHidden = false
            emailLabel.isHidden = false
        } else {
            nameLabel.isHidden = true
            emailLabel.isHidden = true
        }
    }

    func buttonInit() {
        if userViewModel?.isSubscribeAlertBecomeActive == false {
            if userViewModel?.mode == .subscribed {
                subscribeButton.isHidden = true
                subscribeButton.isEnabled = false
                unsubscribeButton.isHidden = false
                unsubscribeButton.isEnabled = true
            } else {
                subscribeButton.isHidden = false
                subscribeButton.isEnabled = true
                unsubscribeButton.isHidden = true
                unsubscribeButton.isEnabled = false
            }
        } else {
            subscribeButton.isHidden = true
            subscribeButton.isEnabled = false
            unsubscribeButton.isHidden = true
            unsubscribeButton.isEnabled = false
        }
    }
    
    @IBAction func onSubscribeClick(_ sender: Any) {
        delegate?.subscribe()
    }
    @IBAction func onUnsubscribeClick(_ sender: Any) {
        delegate?.unsubscribe()
    }
}
