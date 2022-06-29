//
//  RegisterView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 27/04/2022.
//

import Foundation
import UIKit

class RegisterView: UIView {
    
    private let titleStack = UIStackView()
    private let primaryText = UILabel()
    private let secondaryText = UILabel()
    private let fieldsStack = UIStackView()
    
    let loginField = LoginField()
    let passField = LoginField()
    let repeatPassField = LoginField()
    let spinner = UIActivityIndicatorView()
    let registerButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTitleStack()
        addPrimaryText()
        addSecondaryText()
        addFieldsStack()
        addLoginField()
        addPassField()
        addRepeatPassField()
        addRegisterButton()
        addSpinner()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension RegisterView {
    
    func addTitleStack() {
        addSubview(titleStack)
        
        titleStack.axis = .vertical
        titleStack.alignment = .leading
        titleStack.distribution = .fillEqually
        titleStack.spacing = 5
        
        titleStack.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(safeAreaLayoutGuide).inset(70)
        }
    }
    
    func addPrimaryText() {
        titleStack.addArrangedSubview(primaryText)
        
        primaryText.font = UIFont.boldSystemFont(ofSize: 40)
        primaryText.text = "Create new"
    }
    
    func addSecondaryText() {
        titleStack.addArrangedSubview(secondaryText)
        
        secondaryText.font = UIFont.boldSystemFont(ofSize: 40)
        secondaryText.text = "account"
    }
    
    func addFieldsStack() {
        addSubview(fieldsStack)
        
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .fill
        fieldsStack.distribution = .fill
        fieldsStack.spacing = 20
        fieldsStack.contentMode = .scaleToFill
        fieldsStack.semanticContentAttribute = .unspecified
        
        fieldsStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.center.equalToSuperview()
        }
    }
    
    
    func addLoginField() {
        fieldsStack.addArrangedSubview(loginField)
        
        loginField.type = .login
        loginField.textField.textContentType = .emailAddress
        
        loginField.textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    func addPassField() {
        fieldsStack.addArrangedSubview(passField)
        
        passField.type = .password
        passField.textField.autocorrectionType = .no
        passField.textField.textContentType = .newPassword

        passField.textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    func addRepeatPassField() {
        fieldsStack.addArrangedSubview(repeatPassField)
        
        repeatPassField.type = .repeatPassword
        repeatPassField.textField.autocorrectionType = .no
        repeatPassField.textField.textContentType = .newPassword

        repeatPassField.textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }

    
    func addRegisterButton() {
        addSubview(registerButton)
        
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 15
        registerButton.setTitle("Sign Up!", for: UIControl.State.normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        registerButton.tintColor = UIColor(named: "bgColor")
        
        registerButton.backgroundColor = .systemGray2
        registerButton.isUserInteractionEnabled = false
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(fieldsStack)
            make.centerX.equalTo(fieldsStack)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-70)
        }
    }
    
    
    func addSpinner() {
        registerButton.addSubview(spinner)
        
        spinner.style = .large
        spinner.hidesWhenStopped = true
        spinner.color = .white
       // spinner.startAnimating()
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}

//MARK: - RegisterView Methods

private extension RegisterView {
    
    @objc func textFieldsDidChange() {
        makeValidation()
    }
    
    func makeValidation()  {
        guard let text = repeatPassField.textField.text else { return }
        guard let login = loginField.textField.text else { return }
        
        if text.count > 0 {
            
            if isValidRepeatPassword(text){
                repeatPassField.bottomLine.backgroundColor = UIColor.systemGreen.cgColor
                repeatPassField.label.textColor = .systemGreen
                
                if  isValidEmail(login) {
                    enableButton()
                } else {
                    disableButton()
                }
            } else {
                repeatPassField.label.textColor = .systemRed
                repeatPassField.bottomLine.backgroundColor = UIColor.systemRed.cgColor
                disableButton()
            }
        }  else {
            repeatPassField.label.textColor = .black
            repeatPassField.bottomLine.backgroundColor = UIColor.systemGray3.cgColor
            disableButton()
        }
    }
    
    func enableButton() {
        registerButton.isUserInteractionEnabled = true
        registerButton.backgroundColor = UIColor(named: "app_color")
    }
    
    func disableButton() {
        registerButton.isUserInteractionEnabled = false
        registerButton.backgroundColor = .systemGray2
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidRepeatPassword(_ pass: String) -> Bool {
        if pass.count > 5 && pass == passField.textField.text {
            return true
        } else {
            return false
        }
    }
}
