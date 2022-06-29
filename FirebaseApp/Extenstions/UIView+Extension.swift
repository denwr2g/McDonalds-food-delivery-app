//
//  UIButton+Extension.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 10/06/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func makeCategoryButton(title: String) -> UIButton {
        
        let button = UIButton(type: .system)
        
        button.configuration = .plain()
        button.setTitle(title, for: .normal)
        
        return button
    }
}


