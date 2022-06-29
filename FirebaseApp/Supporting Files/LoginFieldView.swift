//
//  FormFieldView.swift
//  LoginDemo
//
//  Created by deniss.lobacs on 17/05/2022.
//

import Foundation
import UIKit

private struct Local {
    static let height: CGFloat = 60
    static let tintColorValid: UIColor = UIColor(named: "app_color")!
    static let tintColorInValid: UIColor = .systemRed
    static let backgroundColor: UIColor = .systemGray5
    static let foregroundColor: UIColor = .systemGray
}

class LoginFieldView: UIView {
    
    let label = UILabel()
    let textField = UITextField()
    let cancelButton = makeSymbolButton(systemName: "clear.fill")
    
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

extension LoginFieldView {
    
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
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = UIReturnKeyType.done
        textField.tintColor = UIColor(named: "app_color")!
        textField.isHidden = true
        
        // Button
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.imageView?.tintColor = Local.foregroundColor
        cancelButton.isHidden = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_: )))
        addGestureRecognizer(tap)
    }
    
    
    func undo(view: LoginFieldView) {
        let size = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
            // style
            view.backgroundColor = .systemGray5
            view.label.textColor = .systemGray
            view.layer.borderWidth = 0
            view.layer.borderColor = UIColor.clear.cgColor
            
            // visibility
            view.label.isHidden = false
            view.textField.isHidden = true
            view.textField.text = ""
            view.cancelButton.isHidden = true
            
            // move
            view.label.transform = .identity
        }
        size.startAnimation()
    }
    
    func layout() {
        addSubview(label)
        addSubview(textField)
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            // label
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
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

extension LoginFieldView {
    
    func enterEmailAnimation() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1,
                                                       delay: 0,
                                                       options: []) {
            // style
            self.backgroundColor = .white
            self.label.textColor = .systemGray
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
    
}


// MARK: - TextField Delegate

extension LoginFieldView: UITextFieldDelegate {
    
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
    
}

// MARK: - Factories

func makeSymbolButton(systemName: String) -> UIButton {
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: systemName, withConfiguration: configuration)
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    
    return button
}
