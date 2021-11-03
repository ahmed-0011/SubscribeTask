//
//  SubscribeView.swift
//  SubscribeTask
//
//  Created by ahmed on 24/10/2021.
//

import UIKit

protocol SubscribeViewDelegate {
    func cancel(subscribeViewModel: SubscribeViewModel)
    func subscribe(subscribeViewModel: SubscribeViewModel)
}

class SubscribeView: UIView {
    
    var subscribeViewModel = SubscribeViewModel(name: "", email: "")
    var delegate: SubscribeViewDelegate?
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameErrorLabel: UILabel!
    @IBOutlet var emailErrorLabel: UILabel!
    @IBOutlet var subscribeButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
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
        let view = Bundle(for: SubscribeView.self).loadNibNamed("\(SubscribeView.self)", owner: self)?.first as! UIView
        addSubview(view)
    }
    
    func viewInit() {
        textFieldsInit()
        buttonsInit()
    }
    
    func textFieldsInit() {
        
        if "lang".localized == "ar" {
            nameTextField.textAlignment = .right
            emailTextField.textAlignment = .right
        }
        
        nameTextField.becomeFirstResponder()
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.cornerRadius = 5
        emailTextField.keyboardType = .emailAddress
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.cornerRadius = 5
        
        nameTextField.addTarget(self, action: #selector(didTextFieldBeginChange), for: .editingDidBegin)
        nameTextField.addTarget(self, action: #selector(didTextFieldEndChange), for: .editingDidEnd)
        nameTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(didTextFieldBeginChange), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(didTextFieldEndChange), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
    }
    
    func buttonsInit() {
        cancelButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 10
        subscribeButton.clipsToBounds = true
        subscribeButton.layer.cornerRadius = 10
        subscribeButton.isEnabled = false
        subscribeButton.backgroundColor = UIColor.lightGray
        
        // to round the correct button corners for each language
        if "lang".localized == "en" {
            cancelButton.layer.maskedCorners = .layerMaxXMaxYCorner
            subscribeButton.layer.maskedCorners = .layerMinXMaxYCorner
        } else if "lang".localized == "ar" {
            cancelButton.layer.maskedCorners = .layerMinXMaxYCorner
            subscribeButton.layer.maskedCorners = .layerMaxXMaxYCorner
        }
    }
    
    @IBAction func onCancelClick(_ sender: Any) {
        subscribeViewModel.name = "none".localized
        subscribeViewModel.email = "none".localized
        delegate?.cancel(subscribeViewModel: subscribeViewModel)
    }
    
    @IBAction func onSubscribeClick(_ sender: Any) {
        delegate?.subscribe(subscribeViewModel: subscribeViewModel)
    }
}


// MARK: - Text Fields Action Methods

extension SubscribeView {

    @objc func didTextFieldChanged() {
        
        guard let email = emailTextField.text, let name = nameTextField.text else { return }
        subscribeViewModel.name = name
        subscribeViewModel.email = email
        
        if !subscribeViewModel.isNameValid() && nameTextField.isFirstResponder {
            nameErrorLabel.isHidden = false
            subscribeButton.isEnabled = false
            subscribeButton.backgroundColor = UIColor.lightGray
        } else if !subscribeViewModel.isEmailValid() && emailTextField.isFirstResponder {
            emailErrorLabel.isHidden = false
            subscribeButton.isEnabled = false
            subscribeButton.backgroundColor = UIColor.lightGray
        }
        
        if subscribeViewModel.isNameValid() {
            nameErrorLabel.isHidden = true
            if subscribeViewModel.isEmailValid() {
            }
        }
        if subscribeViewModel.isEmailValid() {
            emailErrorLabel.isHidden = true
        }
        if subscribeViewModel.isNameValid() && subscribeViewModel.isEmailValid() {
            subscribeButton.isEnabled = true
            subscribeButton.backgroundColor = UIColor.blue
        }
    }
    
    @objc func didTextFieldBeginChange(textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    @objc func didTextFieldEndChange(textField: UITextField) {
        textField.layer.borderWidth = 0.0
        textField.layer.borderColor = UIColor.black.cgColor
    }
}
