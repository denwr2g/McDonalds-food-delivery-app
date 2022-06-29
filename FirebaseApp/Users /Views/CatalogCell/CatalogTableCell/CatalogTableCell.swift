//
//  CatalogCell.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 10/06/2022.
//

import UIKit

class CatalogTableCell: UITableViewCell {
    
    static let identifier = "CatalogCell"
    
    let verticalStackView = UIStackView()
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let priceLabel = UILabel()
    
    let horizontalStackView = UIStackView()
    let productImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addHorizontalStackView()
        addVerticalStackView()
        addTitleLabel()
        addDescLabel()
        addPriceLabel()
        addProductImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, price: String, desc: String) {
        titleLabel.text = name
        descLabel.text = desc
        priceLabel.text = price
    }
    
}

private extension CatalogTableCell {
    
    func addHorizontalStackView() {
        addSubview(horizontalStackView)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 20
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    func addVerticalStackView() {
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 6
        
    }
    
    func addTitleLabel() {
        verticalStackView.addArrangedSubview(titleLabel)
        
        titleLabel.text = "Big Mac"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
    }
    
    func addDescLabel() {
        verticalStackView.addArrangedSubview(descLabel)

        descLabel.font = UIFont.systemFont(ofSize: 15)
        descLabel.textColor = .darkGray
        descLabel.numberOfLines = 2
        descLabel.text = "100% liellopu gaļa, kausēts siers, sīpoli, marinēti gurķi, īpašā mērce un sezama sēklu maizīte padara Big Mac® par neaizmirstamu klasiku"
    
    }
    
    func addPriceLabel() {
        verticalStackView.addArrangedSubview(priceLabel)
        
        priceLabel.font = UIFont.systemFont(ofSize: 15)
        priceLabel.textColor = .systemCyan
        priceLabel.text = "15 $"
        
    }
    
    
    func addProductImageView() {
        productImageView.image = UIImage(named: "bigmac")
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 24
        productImageView.layer.masksToBounds = true
        productImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        horizontalStackView.addArrangedSubview(productImageView)
        
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
    }
}
