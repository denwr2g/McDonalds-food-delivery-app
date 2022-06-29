//
//  CategoryButton.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 10/06/2022.
//

import UIKit
import Foundation

class CategoryButton: UIView {
    
    let label = UILabel()
    let button = UIButton()
    
    let bottomLine: CALayer = {
        let line = CALayer()
        
        line.backgroundColor = UIColor.clear.cgColor
        return line
    }()
    
    var isActive: Bool = false {
        didSet {
            changeState()
        }
    }
    
    var onButtonTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBottomLine()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemBackground
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.sizeToFit()
        label.text = ""
        
        addSubview(label)
        addSubview(button)
        
        self.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        button.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
        }
    }
    
    func addBottomLine() {
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 3)

        
        layer.addSublayer(bottomLine)
    }
    
    
    @objc func didTapButton() {
        onButtonTap?()
    }
    
    func changeState() {
        bottomLine.backgroundColor = isActive ? UIColor.purple.cgColor : UIColor.clear.cgColor
        label.textColor = isActive ? .purple : UIColor(named: "darkGray")
      //  self.label.textColor = isActive ? UIColor(named: "lightBlue2") :
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width:label.intrinsicContentSize.width , height: 40)
    }

}

