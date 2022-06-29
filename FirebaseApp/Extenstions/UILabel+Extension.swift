//
//  UIView+Extension.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 08/06/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    @nonobjc class var TSPrimary: UIColor {
        
        return UIColor(red:0.85, green:0.11, blue:0.38, alpha:1.0)
        
    }
    
}

extension UILabel {
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(textField: UITextField, text: String, duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            textField.placeholder = text
            completion(true)
        }
    }
}
