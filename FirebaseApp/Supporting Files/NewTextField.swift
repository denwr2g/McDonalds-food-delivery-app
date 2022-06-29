//
//  NewTextField.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 22/06/2022.
//

import Foundation
import UIKit
import SnapKit

class NewTextField: UIView {
    
    private var appColor = UIColor(named: "app_color")
    
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
    
}

//MARK: - Style

extension NewTextField {
    
    func addBottomLine() {
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        
        layer.addSublayer(bottomLine)
    }
    
    func addLabel() {
        addSubview(label)
        
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "lightBlue")

       // label.isHidden = true
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalToSuperview()
        }
    }
    
    func addTextField() {
        addSubview(textField)
        
        textField.tintColor = appColor
        textField.textColor = .systemGray
      //  textField.placeholder = "placeholder"
        textField.autocorrectionType = .no

        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        textField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
}

//MARK: - Actions

private extension NewTextField {
    
    @objc func textFieldDidChange() {
        //  makeValidation()
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
            
            bottomLine.backgroundColor = UIColor.systemGreen.cgColor
            label.textColor = .systemGreen
                
            
        } else {
            bottomLine.backgroundColor = UIColor.systemRed.cgColor
            label.textColor = .systemRed
        }
    }
    
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

extension NewTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      //  makeLabelAnimated()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        
        return true
    }
    
}
