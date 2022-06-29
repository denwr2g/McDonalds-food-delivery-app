//
//  CollectionViewCell.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 09/05/2022.
//

import UIKit

class CatalogCell: UICollectionViewCell {
    
    static let identifier = "CatalogCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configCell()
    }
    
    
    func configCell() {
        contentView.layer.cornerRadius = 15.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        
                
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width:0 ,height: 2.0)
        layer.shadowRadius = 1.7
        layer.shadowOpacity = 0.45
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func configure(name: String, price: String) {
        nameLabel.text = name
        priceLabel.text = price
    }
}
