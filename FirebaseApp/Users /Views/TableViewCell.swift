//
//  TableViewCell.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 20/06/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(name: String, price: String) {
        self.name.text = name
        self.priceLabel.text = price
    }
}
