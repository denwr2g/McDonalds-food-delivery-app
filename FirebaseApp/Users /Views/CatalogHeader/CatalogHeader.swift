//
//  CatalogHeader.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 10/06/2022.
//

import UIKit

class CatalogHeader: UIView {
    
    let title = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTitle()
        addImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
    }
    
    func addTitle() {
        addSubview(title)
        title.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        title.text = "Burgers"
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    func addImage() {
        addSubview(imageView)
        
        imageView.image = UIImage(named: "breakfastLogo")
        
        imageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }

}
