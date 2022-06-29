//
//  OrderCell.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 24/05/2022.
//

import UIKit

class OrderCell: UITableViewCell {

    static let identifier = "OrderCell"
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func configCell(_ order: Order) {
        self.costLabel.text = "\(order.cost) $"
        self.dateLabel.text = order.formatedDate
        self.statusLabel.text = order.status
        
        switch(order.status) {
        case "New": self.statusLabel.textColor = UIColor(named: "darkGreen")
        case "Cooking": self.statusLabel.textColor = .black
        case "Delivering": self.statusLabel.textColor = .systemCyan
        case "Completed": self.statusLabel.textColor = .systemGreen
        case "Cancelled": self.statusLabel.textColor = .systemRed
        default: self.statusLabel.textColor = .systemYellow
        }
    }
    
}
