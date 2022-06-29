//
//  LoginView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 28/04/2022.
//

import Foundation
import UIKit

class LoginView: UIView {
        
    private let titleStack = UIStackView()
    private let primaryText = UILabel()
    private let secondaryText = UILabel()    
    private let fieldsStack = UIStackView()
    
    let loginField = LoginField()
    let passField = LoginField()
    let loginButton = UIButton(type: .system)
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addTitleStack()
        addPrimaryText()
        addSecondaryText()
        addFieldsStack()
        addLoginField()
        addPassField()
        addSpinner()
        addLoginButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension LoginView {
    
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
        primaryText.text = "Welcome"
    }
    
    func addSecondaryText() {
        titleStack.addArrangedSubview(secondaryText)

        secondaryText.font = UIFont.boldSystemFont(ofSize: 40)
        secondaryText.text = "back!"
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
        loginField.textField.text = "1@2.com"
    }
    
    func addPassField() {
        fieldsStack.addArrangedSubview(passField)
        
        passField.type = .password
        passField.textField.textContentType = .password
        passField.textField.text = "123456"
    }
    
    func addSpinner() {
        loginButton.addSubview(spinner)
        
        spinner.style = .large
        spinner.hidesWhenStopped = true
        spinner.color = .white
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func addLoginButton() {
        addSubview(loginButton)
        
        loginButton.backgroundColor = UIColor(named: "app_color")
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.cornerRadius = 15
        loginButton.setTitle("Sign In!", for: UIControl.State.normal)
        loginButton.tintColor = UIColor(named: "bgColor")
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)

        loginButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(fieldsStack)
            make.centerX.equalTo(fieldsStack)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-70)
        }
    }

}

