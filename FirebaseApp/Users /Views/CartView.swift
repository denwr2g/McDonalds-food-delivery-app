//
//  CartView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 23/05/2022.
//

import Foundation
import UIKit

class CartView: UIView {
    
    var tableView = UITableView()
    var totalStackView = UIStackView()
    var totalLabel = UILabel()
    var totalPriceLabel = UILabel()
    var buttonsStackView = UIStackView()
    var cancelButton = UIButton(type: .system)
    var makeOrderButton = UIButton(type: .system)
    var bottomBarStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addTableView()
        addTotalStackView()
        addTotalLabel()
        addTotalPriceLabel()
        addButtonsStackView()
        addCancelButton()
        addMakeOrderButton()
        addBottomBarStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - UI Elements Configuration

private extension CartView {
    
    func addTableView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(500)
        }
    }
    
    func addTotalStackView() {
        bottomBarStackView.addArrangedSubview(totalStackView)
        
        totalStackView.axis = .horizontal
        totalStackView.alignment = .fill
        totalStackView.distribution = .fill
        totalStackView.spacing = 10
        totalStackView.contentMode = .scaleToFill
        totalStackView.semanticContentAttribute = .unspecified
    }
    
    func addTotalLabel() {
        totalStackView.addArrangedSubview(totalLabel)
        
        totalLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalLabel.text = "Total:"
    }
    
    func addTotalPriceLabel() {
        totalStackView.addArrangedSubview(totalPriceLabel)
        
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        totalPriceLabel.text = "150 $"
    }
    
    func addButtonsStackView() {
        bottomBarStackView.addArrangedSubview(buttonsStackView)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20
        buttonsStackView.contentMode = .scaleToFill
        buttonsStackView.semanticContentAttribute = .unspecified
    }
    
    func addCancelButton() {
        buttonsStackView.addArrangedSubview(cancelButton)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.minimumScaleFactor = 0.5
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.titleLabel?.adjustsFontSizeToFitWidth = true
        cancelButton.backgroundColor = .systemRed
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 10
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    func addMakeOrderButton() {
        buttonsStackView.addArrangedSubview(makeOrderButton)
        
        makeOrderButton.setTitle("Order", for: .normal)
        makeOrderButton.titleLabel?.minimumScaleFactor = 0.5
        makeOrderButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        makeOrderButton.titleLabel?.adjustsFontSizeToFitWidth = true
        makeOrderButton.backgroundColor = .systemGreen
        makeOrderButton.setTitleColor(.white, for: .normal)
        makeOrderButton.layer.cornerRadius = 10
        
        makeOrderButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    func addBottomBarStackView() {
        addSubview(bottomBarStackView)
        
        bottomBarStackView.axis = .vertical
        bottomBarStackView.alignment = .fill
        bottomBarStackView.distribution = .fillEqually
        bottomBarStackView.spacing = 10
        bottomBarStackView.contentMode = .scaleToFill
        bottomBarStackView.semanticContentAttribute = .unspecified
        
        bottomBarStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
