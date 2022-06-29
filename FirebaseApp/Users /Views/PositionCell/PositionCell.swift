//
//  PositionCell.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 23/05/2022.
//

import UIKit

class PositionCell: UITableViewCell {
    
    static let identifier = "PositionCell"
    
    @IBOutlet weak var positionProductTitle: UILabel!
    @IBOutlet weak var positionCount: UILabel!
    @IBOutlet weak var positionPrice: UILabel!
    
    func configCell(_ position: Position) {
        self.positionProductTitle.text = position.product.title
        self.positionCount.text = "\(position.count) pieces"
        self.positionPrice.text = "\(position.cost) $"
    }
    
}
