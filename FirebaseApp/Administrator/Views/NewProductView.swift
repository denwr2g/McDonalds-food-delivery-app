//
//  NewProductView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 02/06/2022.
//

import Foundation
import UIKit

class NewProductView: UIView {
    
    var verticalStackView = UIStackView()

    var titleLabel = UILabel()
    
    var productImage = UIImage()
    var productImageView = UIImageView()
    
    var pickerView = UIPickerView()

    var productNameTF = NewTextField()
    var productPriceTF = NewTextField()
    var productDescriptTF = NewTextField()
    var productCategoryTF = NewTextField()
    
    var horizontalStackView = UIStackView()
    var switchLabel = UILabel()
    var typeSwitch = UISwitch()
    
    var button = UIButton()
    
    let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))


    override init(frame: CGRect) {
        super.init(frame: frame)
          
        
        addProductImage()
        addProductImageView()
        
        addVerticalStackView()

        addTitleTF()
        addDescriptTF()
        addPriceTF()
        addCategoryTF()
        
        addHorizontalStackView()
        addSwitchLabel()
        addTypeSwitch()
        
        addButton()
        addBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
    }
    
}

private extension NewProductView {
    
    func addVerticalStackView() {
        addSubview(verticalStackView)
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 15
        verticalStackView.contentMode = .scaleToFill
        verticalStackView.semanticContentAttribute = .unspecified
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func addTitleLabel() {
        verticalStackView.addArrangedSubview(titleLabel)
        
        titleLabel.text = "Add Product"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
    }
    
    func addProductImage() {
        productImage = UIImage(named: "bigmac")!
    }

    func addProductImageView() {
        productImageView = UIImageView(image: productImage)
        productImageView.contentMode = .scaleToFill
        productImageView.layer.cornerRadius = 24
        productImageView.layer.masksToBounds = true
        productImageView.isUserInteractionEnabled = true
        
        verticalStackView.addArrangedSubview(productImageView)
        
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
    }
    
    func addTitleTF() {
        verticalStackView.addArrangedSubview(productNameTF)
        
        productNameTF.label.text = "Title"
        
        productNameTF.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    func addPriceTF() {
        verticalStackView.addArrangedSubview(productPriceTF)
        
        productPriceTF.label.text = "Price"
        productPriceTF.textField.keyboardType = .decimalPad
        
        productPriceTF.textField.inputAccessoryView = numberToolbar

        productPriceTF.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

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
    
    func addDescriptTF() {
        verticalStackView.addArrangedSubview(productDescriptTF)

        productDescriptTF.label.text = "Description"
        
        productDescriptTF.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    func addCategoryTF() {
        verticalStackView.addArrangedSubview(productCategoryTF)

        productCategoryTF.label.text = "Category"
        productCategoryTF.textField.inputView = pickerView

        productCategoryTF.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    func addHorizontalStackView() {
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
      
        
    }
    
    func addSwitchLabel() {
        horizontalStackView.addArrangedSubview(switchLabel)
        
        switchLabel.textColor = UIColor(named: "lightBlue")
        switchLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        switchLabel.text = "Countable:"
    }
    
    func addTypeSwitch() {
        horizontalStackView.addArrangedSubview(typeSwitch)
        
        typeSwitch.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        typeSwitch.isOn = false
    }
    
    func addButton() {
        verticalStackView.addArrangedSubview(button)
        
        button.backgroundColor = UIColor(named: "lightBlue")
        button.layer.cornerRadius = 16
        button.setTitle("Save", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: .normal)

        button.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    

}

