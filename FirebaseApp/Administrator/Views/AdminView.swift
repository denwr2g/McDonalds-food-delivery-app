//
//  AdminView.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 27/05/2022.
//

import Foundation
import UIKit

class AdminView: UIView {
    
    var tableView = UITableView()
    var indicator = UIActivityIndicatorView()
    var floatingButton = UIButton()
    var listButton = UIButton()
    var messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTableView()
        addIndicator()
        addFloatingButton()
        addProductsButton()
        addMessage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
    }
    
}

private extension AdminView {
    
    func addTableView() {
        addSubview(tableView)
        
        tableView.isHidden = true
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.left.right.equalToSuperview().inset(10)
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
            make.center.equalToSuperview()
        }
    }
    
    func addFloatingButton() {
        addSubview(floatingButton)
        
        floatingButton.backgroundColor = .systemPink
        
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        floatingButton.setImage(image, for: .normal)
        floatingButton.tintColor = .white
        floatingButton.setTitleColor(.white, for: .normal)
        floatingButton.layer.shadowRadius = 10
        floatingButton.layer.shadowOpacity = 0.3
        floatingButton.layer.cornerRadius = 30
        
        floatingButton .snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    func addProductsButton() {
        addSubview(listButton)
        
        listButton.backgroundColor = .systemPink
        
        let image = UIImage(systemName: "list.bullet", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        listButton.setImage(image, for: .normal)
        listButton.tintColor = .white
        listButton.setTitleColor(.white, for: .normal)
        listButton.layer.shadowRadius = 10
        listButton.layer.shadowOpacity = 0.3
        listButton.layer.cornerRadius = 30
        
        listButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.left.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
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
