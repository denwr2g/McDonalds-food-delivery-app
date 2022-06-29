//
//  OrderView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 27/05/2022.
//

import UIKit

class OrderView: UIView {
    
    var verticalStackView = UIStackView()
    
    var nameLabel = UILabel()
    var phoneLabel = UILabel()
    var addressLabel = UILabel()
    var statusTextField = CustomTextField()
    var pickerView = UIPickerView()
    var tableView = UITableView()
    
    var horizontalStackView = UIStackView()
    var totalCostTextLabel = UILabel()
    var totalCostLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addVerticalStackView()
        
        addNameLabel()
        addPhoneLabel()
        addAddressLabel()
        addStatusTextField()
        addTableView()

        addHorizontalStackView()
        addTotalCostTextLabel()
        addTotalCostLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
    }
}

extension OrderView {
    
    private func addVerticalStackView() {
        addSubview(verticalStackView)
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 10
        verticalStackView.contentMode = .scaleToFill
        verticalStackView.semanticContentAttribute = .unspecified
        
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(25)
            make.left.right.equalToSuperview().inset(10)
           // make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    private func addNameLabel() {
        verticalStackView.addArrangedSubview(nameLabel)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.text = "Name Surname"
    }
    
    private func addPhoneLabel() {
        verticalStackView.addArrangedSubview(phoneLabel)
        
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 18)
        phoneLabel.text = "Phone number"
    }
    
    private func addAddressLabel() {
        verticalStackView.addArrangedSubview(addressLabel)
        
        addressLabel.text = "Delivery address"
    }
    
    private func addStatusTextField() {
        verticalStackView.addArrangedSubview(statusTextField)
        
        statusTextField.inputView = pickerView
        
        statusTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }

    }
    
    private func addTableView() {
        verticalStackView.addArrangedSubview(tableView)
    }
    
    private func addHorizontalStackView() {
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 0
        horizontalStackView.contentMode = .scaleToFill
        horizontalStackView.semanticContentAttribute = .unspecified
    
    }
    
    private func addTotalCostTextLabel() {
        horizontalStackView.addArrangedSubview(totalCostTextLabel)
        
        totalCostTextLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalCostTextLabel.text = "TOTAL:"
    }
    
    private func addTotalCostLabel() {
        horizontalStackView.addArrangedSubview(totalCostLabel)
        
        totalCostLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalCostLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        totalCostLabel.textColor = .systemGreen
        totalCostLabel.text = "500 $"
    }
}
