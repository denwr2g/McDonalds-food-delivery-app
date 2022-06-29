//
//  CatalogDetailView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 11/05/2022.
//

import Foundation
import UIKit

class CatalogDetailView: UIView {
    
    var image = UIImage()
    var image1 = UIImageView()
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let descriptionLabel = UILabel()
    let toCartButton = UIButton(type: .system)
    let stepperStackView = UIStackView()
    let stepper = UIStepper()
    let countLabel = UILabel()
    
    var segmentedController: UISegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addImage()
        addImageView()
        addStackView()
        addTitleLabel()
        addPriceLabel()
        addDescriptionLabel()
        addStepperStackView()
        addStepper()
        addCountLabel()
        addSegmentedController()
        addToCartButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension CatalogDetailView {
    
    func addImage() {
        image = UIImage(named: "bigmac")!
    }
    
    func addImageView() {
        image1 = UIImageView(image: image)
        image1.contentMode = .scaleToFill
        
        addSubview(image1)
        
        image1.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(260)
        }
    }
    
    func addStackView() {
        addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 30
        stackView.contentMode = .scaleToFill
        stackView.semanticContentAttribute = .unspecified
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(image1.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    func addTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 2
    }
    
    func addPriceLabel() {
        stackView.addArrangedSubview(priceLabel)
        
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        priceLabel.textColor = .systemCyan
        priceLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func addDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .systemGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(stackView.snp.bottom).offset(20)
           // make.height.equalTo(100)
        }
    }
    
    func addSegmentedController() {
        
        let types = ["Small", "Medium", "Large"]
        segmentedController = UISegmentedControl(items: types)
        segmentedController.selectedSegmentIndex = 0
        segmentedController.tintColor = UIColor.systemCyan
        segmentedController.isEnabled = false
        
        addSubview(segmentedController)
        
        segmentedController.snp.makeConstraints { make in
            make.top.equalTo(stepperStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func addStepperStackView() {
        addSubview(stepperStackView)
        
        stepperStackView.axis = .horizontal
        stepperStackView.alignment = .fill
        stepperStackView.distribution = .fill
        stepperStackView.spacing = 10
        stepperStackView.contentMode = .scaleToFill
        stepperStackView.semanticContentAttribute = .unspecified
        
        stepperStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    
    func addStepper() {
        stepperStackView.addArrangedSubview(stepper)

        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
    
    func addCountLabel() {
        stepperStackView.addArrangedSubview(countLabel)
        
        countLabel.text = "1"
        countLabel.textAlignment = .right
    }
    
    func addToCartButton() {
        addSubview(toCartButton)
        
        toCartButton.setTitle("Add to cart", for: .normal)
        toCartButton.titleLabel?.minimumScaleFactor = 0.5
        toCartButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        toCartButton.titleLabel?.adjustsFontSizeToFitWidth = true
        toCartButton.backgroundColor = .systemCyan
        toCartButton.setTitleColor(.white, for: .normal)
        toCartButton.layer.cornerRadius = 40 / 2
        
        toCartButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(250)
            make.top.equalTo(segmentedController.snp.bottom).offset(30)
            make.centerX.equalTo(segmentedController)
        }
    }
        
}
