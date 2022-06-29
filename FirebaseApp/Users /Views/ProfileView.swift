//
//  ProfileView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 03/05/2022.
//

import UIKit

class ProfileView: UIView {
    
    var profileStackView = UIStackView()
    
    var nameLabel = UITextField()
    var phoneLabel = UITextField()
    var vStackView = UIStackView()
    var userImageView = UIImageView()
    var hStackView = UIStackView()
    
    var addressStackView = UIStackView()
    var addressTextLabel = UILabel()
    var addressLabel = UITextField()
    
    var ordersTextLabel = UILabel()
    var tableView = UITableView()
    var indicator = UIActivityIndicatorView()
    var messageLabel = UILabel()
    let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addProfileStackView()
        addUserImageView()
        addNameLabel()
        addPhoneLabel()
        addVStackView()
        addHStackView()
        
        addAddressStackView()
        addAddressTextLabel()
        addAddressLabel()
        
        addOrdersTextLabel()
        addTableView()
        addIndicator()
        addMessage()
        addBar()
        
        nameLabel.delegate = self
        phoneLabel.delegate = self
        addressLabel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension ProfileView {
    
    func addProfileStackView() {
        addSubview(profileStackView)
        
        profileStackView.axis = .vertical
        profileStackView.alignment = .fill
        profileStackView.distribution = .fillEqually
        profileStackView.spacing = 15
        profileStackView.contentMode = .scaleToFill
        profileStackView.semanticContentAttribute = .unspecified
        
        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(25)
            
        }
    }
    
    func addUserImageView() {
        hStackView.addArrangedSubview(userImageView)
        
        userImageView.image = UIImage(named: "user2")
        userImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_: ))))
                
        userImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
    }
    
    
    
    func addNameLabel() {
        vStackView.addArrangedSubview(nameLabel)
        
        nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        nameLabel.placeholder = "Enter your name"
        nameLabel.returnKeyType = .done
    }
    
    func addPhoneLabel() {
        vStackView.addArrangedSubview(phoneLabel)
        
        phoneLabel.placeholder = "Enter your phone number"
        phoneLabel.returnKeyType = .done
        phoneLabel.keyboardType = .phonePad
        phoneLabel.inputAccessoryView = numberToolbar
    }
    
    func addBar() {
        
        numberToolbar.barStyle = .default
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        numberToolbar.items = [flexibleSpace, doneButton]
        numberToolbar.sizeToFit()
    }
    
    @objc func doneClicked() {
        self.endEditing(true)
    }
    
    func addVStackView() {
        hStackView.addArrangedSubview(vStackView)
        
        vStackView.axis = .vertical
        vStackView.alignment = .fill
        vStackView.distribution = .fillEqually
        vStackView.spacing = 5
        vStackView.contentMode = .scaleToFill
        vStackView.semanticContentAttribute = .unspecified
        
    }
    
    func addHStackView() {
        profileStackView.addArrangedSubview(hStackView)
        
        hStackView.axis = .horizontal
        hStackView.alignment = .fill
        hStackView.distribution = .fill
        hStackView.spacing = 20
        hStackView.contentMode = .scaleToFill
        hStackView.semanticContentAttribute = .unspecified
        
    }
    
    func addAddressStackView() {
        profileStackView.addArrangedSubview(addressStackView)

        addressStackView.axis = .vertical
        addressStackView.alignment = .fill
        addressStackView.distribution = .fillEqually
        addressStackView.spacing = 1
        addressStackView.contentMode = .scaleToFill
        addressStackView.semanticContentAttribute = .unspecified
        
    }
    
    func addAddressTextLabel() {
        addressStackView.addArrangedSubview(addressTextLabel)
        
        addressTextLabel.font = UIFont.boldSystemFont(ofSize: 18)
        addressTextLabel.text = "Delivery address:"
    }
    
    func addAddressLabel() {
        addressStackView.addArrangedSubview(addressLabel)

        addressLabel.placeholder = "Enter your delivery address"
        addressLabel.returnKeyType = .done
    }
    
    func addOrdersTextLabel() {
        addSubview(ordersTextLabel)
        
        ordersTextLabel.font = UIFont.boldSystemFont(ofSize: 18)
        ordersTextLabel.text = "Your orders will be here:"
        
        ordersTextLabel.snp.makeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
    }
    
    func addTableView() {
        addSubview(tableView)
        
        tableView.isHidden = true
                
        tableView.snp.makeConstraints { make in
            make.top.equalTo(ordersTextLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
        }
    }
    
    func addIndicator() {
        addSubview(indicator)
        
        indicator.style = .large
        indicator.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        indicator.hidesWhenStopped = true
        indicator.color = .systemMint
        indicator.startAnimating()
        
        indicator.snp.makeConstraints { make in
            make.top.equalTo(ordersTextLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func addMessage() {
        addSubview(messageLabel)
        
        messageLabel.isHidden = true
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        messageLabel.textColor = .systemCyan
        messageLabel.text = "Order list is empty"
        
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Actions

extension ProfileView {
        
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            print("printed")
        }
        
    }
}

extension ProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        
        return true
    }
}
