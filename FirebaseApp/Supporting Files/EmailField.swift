//
//  VerificationFieldView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 06/06/2022.
//

import Foundation
import UIKit


private struct Local {
    static let height: CGFloat = 60
    static let tintColorValid: UIColor = .systemGreen
    static let tintColorInValid: UIColor = .systemRed
    static let backgroundColor: UIColor = .systemGray5
    static let foregroundColor: UIColor = .systemGray
}

class EmailField: UIView {
    
    let label = UILabel()
    let invalidLabel = UILabel()
    let textField = UITextField()
    let cancelButton = makeSymbolButton(systemName: "clear.fill", target: self, selector: #selector(cancelTapped(_:)))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }
}

extension EmailField {
    
    func setup() {
        textField.delegate = self
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 60 / 4
        
        // Label
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.text = "Email"
        
        // Invalid
        
        invalidLabel.translatesAutoresizingMaskIntoConstraints = false
        invalidLabel.textColor = Local.tintColorInValid
        invalidLabel.text = "Email is invalid"
        invalidLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        invalidLabel.isHidden = true
        
        // textfield
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = UIReturnKeyType.done
        textField.tintColor = .systemGreen
        textField.isHidden = true
        
        // Button
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.imageView?.tintColor = Local.foregroundColor
        cancelButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_: )))
        addGestureRecognizer(tap)
    }
    
    func layout() {
        addSubview(label)
        addSubview(invalidLabel)
        addSubview(textField)
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            // label
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            // invalidLabel
            invalidLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            invalidLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            // textfield
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 2),
            
            // button
            cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: cancelButton.trailingAnchor, multiplier: 2),
        ])
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            enterEmailAnimation()
        }
    }
}

//MARK: - Animations

extension EmailField {
    
    func enterEmailAnimation() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1,
                                                       delay: 0,
                                                       options: []) {
            // style
            self.backgroundColor = .white
            self.label.textColor = .systemGreen
            self.layer.borderWidth = 1
            self.layer.borderColor = self.label.textColor.cgColor
            self.textField.tintColor = Local.tintColorValid
            
            // move
            let transpose = CGAffineTransform(translationX: -8, y: -24)
            let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.label.transform = transpose.concatenating(scale)
            
        } completion: { position in
            self.textField.isHidden = false
            self.textField.becomeFirstResponder()
            self.cancelButton.isHidden = false
        }
    }
    
    func showInvalidEmailMessage() {
        label.isHidden = true
        invalidLabel.isHidden = false
        invalidLabel.text = "Email is invalid"
        invalidLabel.textColor = Local.tintColorInValid
        layer.borderColor = Local.tintColorInValid.cgColor
        textField.tintColor = Local.tintColorInValid
        
        
    }
    
    func validEmail() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1,
                                                       delay: 0,
                                                       options: []) {
            // style
            self.backgroundColor = .white
            self.label.textColor = .systemGreen
            self.layer.borderWidth = 1
            self.layer.borderColor = self.label.textColor.cgColor
            self.textField.tintColor = Local.tintColorValid
            self.invalidLabel.textColor = Local.tintColorValid
            self.invalidLabel.text = "Email"
            
            // move
            let transpose = CGAffineTransform(translationX: -8, y: -24)
            let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.label.transform = transpose.concatenating(scale)
            
        } completion: { position in
            self.textField.isHidden = false
            self.cancelButton.isHidden = false
        }
        
        
    }
}

// MARK: - Actions

extension EmailField {
    func undo() {
        let size = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
            // style
            self.backgroundColor = .systemGray5
            self.label.textColor = .systemGray
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
            
            // visibility
            self.label.isHidden = false
            self.invalidLabel.isHidden = true
            self.textField.isHidden = true
            self.textField.text = ""
            self.cancelButton.isHidden = true
            
            // move
            self.label.transform = .identity
        }
        size.startAnimation()
    }
    
    @objc func cancelTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
        undo()
    }
}

// MARK: - TextField Delegate

extension EmailField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let emailText = textField.text else { return }
        
        if isValidEmail(emailText) {
            //               self.label.text = "Email is valid"
            validEmail()
            // undo()
        } else {
            showInvalidEmailMessage()
        }
        
        //  textField.text = ""
    }
}

// MARK: - Factories

func makeSymbolButton(systemName: String, target: Any, selector: Selector) -> UIButton {
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: systemName, withConfiguration: configuration)
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(target, action: selector, for: .primaryActionTriggered)
    button.setImage(image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    
    return button
}

// MARK: Utils

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
