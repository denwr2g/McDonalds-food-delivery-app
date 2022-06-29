//
//  WelcomeView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 26/04/2022.
//

import UIKit

class HomeView: UIView {
    
    private let titleStack = UIStackView()
    private let primaryText = UILabel()
    private let secondaryText = UILabel()
    
    private let logo = UIImageView(image: UIImage(named: "app_logo"))
    
    private let buttonsStack = UIStackView()
    let signUpButton = UIButton(type: .system)
    let loginButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addTitleStack()
        addPrimaryText()
        addSecondaryText()
        addLogo()
        addButtonsStack()
        addLoginButton()
        addSignUpButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension HomeView {
    
    func addTitleStack() {
        addSubview(titleStack)
        
        titleStack.axis = .vertical
        titleStack.alignment = .center
        titleStack.distribution = .fillEqually
        titleStack.spacing = 5

        titleStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).inset(80)
        }
    }
    
    func addPrimaryText() {
        titleStack.addArrangedSubview(primaryText)

        primaryText.font = UIFont.boldSystemFont(ofSize: 40)
        primaryText.text = "Welcome!"
    }
    
    func addSecondaryText() {
        titleStack.addArrangedSubview(secondaryText)

        secondaryText.font = UIFont.boldSystemFont(ofSize: 16)
        secondaryText.textColor = .systemGray4
        secondaryText.text = "Sign in or create a new account"
    }

    
    func addLogo() {
        addSubview(logo)
        
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleStack.snp.bottom).offset(80)
            make.height.width.equalTo(180)
        }
    }
    
    func addButtonsStack() {
        addSubview(buttonsStack)
        
        buttonsStack.axis = .vertical
        buttonsStack.alignment = .center
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 15
        
        buttonsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(50)
        }
    }
    
    func addLoginButton() {
        buttonsStack.addArrangedSubview(loginButton)
        
        loginButton.backgroundColor = UIColor(named: "app_color")
        loginButton.layer.cornerRadius = 15
        loginButton.setTitle("Go To Sign In", for: UIControl.State.normal)
        loginButton.tintColor = UIColor(named: "bgColor")
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(buttonsStack)
        }
    }
    
    func addSignUpButton() {
        buttonsStack.addArrangedSubview(signUpButton)
        
        signUpButton.backgroundColor = UIColor.white
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.borderColor = UIColor(named: "lightGray")?.cgColor
        signUpButton.layer.borderWidth = 2.0
        signUpButton.setTitleColor(UIColor.gray, for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signUpButton.tintColor = UIColor(named: "bgColor")
        
        let att = NSMutableAttributedString(string: "No account yet? Sign up!")
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: 12))
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "app_color")!, range: NSRange(location: 16, length: 8))
        signUpButton.setAttributedTitle(att, for: .normal)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(buttonsStack)
        }
    }
    
}
