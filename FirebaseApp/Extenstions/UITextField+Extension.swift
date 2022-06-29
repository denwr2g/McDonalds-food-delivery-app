//
//  UITextField+Extension.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 29/04/2022.
//

import Foundation
import UIKit

extension UITextField {

    func useUnderline() {

        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
