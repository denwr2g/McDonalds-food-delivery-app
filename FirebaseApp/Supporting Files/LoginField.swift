//
//  LoginField.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 08/06/2022.
//

import Foundation
import UIKit

enum FieldType: Int {
    case login = 0
    case password = 1
    case repeatPassword = 2
}

class LoginField: UIView {
    
    private var appColor = UIColor(named: "app_color")
    
    var type: FieldType = .login {
        didSet {
            switch self.type.rawValue {
            case 0: useLoginField()
            case 1: usePasswordField()
            case 2: useRepeatPasswordField()
            default: break
            }
        }
    }
    
    let bottomLine: CALayer = {
        let line = CALayer()
        line.backgroundColor = UIColor.systemGray.cgColor
        return line
    }()
    
    let label = UILabel()
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addLabel()
        addTextField()
        
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBottomLine()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }
    
    private func useLoginField() {
        textField.isSecureTextEntry = false
        textField.returnKeyType = .next
      //  textField.textContentType = .emailAddress

    }
    
    private func usePasswordField() {
        label.text = "Passowrd"
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.placeholder = "Enter your password"

    }
    
    private func useRepeatPasswordField() {
        label.text = "Repeat passowrd"
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.placeholder = "Repeat your password"

    }
}

//MARK: - Style

extension LoginField {
    
    func addBottomLine() {
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        
        layer.addSublayer(bottomLine)
    }
    
    func addLabel() {
        addSubview(label)
        
        label.text = "Email"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.isHidden = true
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview()
        }
    }
    
    func addTextField() {
        addSubview(textField)
        
        textField.tintColor = appColor
        textField.textColor = .systemGray
        textField.placeholder = "name@example.com"
        textField.autocorrectionType = .no


        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        textField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
}

//MARK: - Actions

private extension LoginField {
    
    @objc func textFieldDidChange() {
        makeValidation()
    }
    
    func makeLabelAnimated() {
        if textField.text?.count == 0 {
            textField.resignFirstResponder()
            textField.placeholder = ""
            label.fadeIn()
        } else {
            label.isHidden = false
        }
    }
    
    func makeValidation() {
        guard let text = textField.text else { return }
        
        if text.count > 0 {
            
            if type.rawValue == 0 {
                if isValidEmail(text) {
                    bottomLine.backgroundColor = UIColor.systemGreen.cgColor
                    label.textColor = .systemGreen
                } else {
                    bottomLine.backgroundColor = UIColor.systemRed.cgColor
                    label.textColor = .systemRed
                }
                
            } else if type.rawValue == 1 {
                if isValidPassword(text) {
                    bottomLine.backgroundColor = UIColor.systemGreen.cgColor
                    label.textColor = .systemGreen
                } else {
                    bottomLine.backgroundColor = UIColor.systemRed.cgColor
                    label.textColor = .systemRed
                }
            }
            
            else if type.rawValue == 2 {
                if isValidPassword(text) {
                    bottomLine.backgroundColor = UIColor.systemGreen.cgColor
                    label.textColor = .systemGreen
                } else {
                    bottomLine.backgroundColor = UIColor.systemRed.cgColor
                    label.textColor = .systemRed
                }
            }
        } else {
            bottomLine.backgroundColor = UIColor.systemGray3.cgColor
            label.textColor = .black
        }
    }
    
//    private func makeValidation() {
//        guard let text = repeatPassField.textField.text else { return }
//
//        if text.count > 0 {
//            if isValidRepeatPassword(text) {
//                repeatPassField.bottomLine.backgroundColor = UIColor.systemGreen.cgColor
//                repeatPassField.label.textColor = .systemGreen
//            } else {
//                repeatPassField.bottomLine.backgroundColor = UIColor.systemRed.cgColor
//                repeatPassField.label.textColor = .systemRed
//            }
//        }  else {
//            repeatPassField.bottomLine.backgroundColor = UIColor.systemGray3.cgColor
//            repeatPassField.label.textColor = .black
//        }
//    }
    
 
    
    private func isValidPassword(_ pass: String) -> Bool {
        
        if pass.count > 5 {
            return true
        } else {
            return false
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

//MARK: TextField Delegate

extension LoginField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        makeLabelAnimated()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        
        switch type.rawValue {
        case 0: label.fadeOut(textField: textField, text: "name@example.com")
        case 1: label.fadeOut(textField: textField, text: "Enter your password")
        case 2: label.fadeOut(textField: textField, text: "Repeat your password")
        default: break
        }
        
//        let text = type.rawValue == 0 ? "name@example.com" : "Enter your password"
//        label.fadeOut(textField: textField, text: text)
        
        return true
    }
    
}
