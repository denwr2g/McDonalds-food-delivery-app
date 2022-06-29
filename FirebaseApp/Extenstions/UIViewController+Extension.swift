//
//  CustomOutlinedTextField.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 28/04/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showLogoutAlert(completion: @escaping () -> Void ) {
        let alert = UIAlertController(title: "Log out?", message: "Are you sure you want to log out of your account?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: { action in
            completion()
        }))
        
        present(alert, animated: true)
    }
    func makeOrderSheet(completion: @escaping () -> Void) {
        let actionSheet = UIAlertController(title: "Title", message: "Are you sure you want to make order?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Order", style: .default, handler: { action in
            completion()
        }))

        present(actionSheet, animated: true)
    }
    
    func errorAlert() {
        let alert = UIAlertController(title: "Email or password is incorrect!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func errorAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func basicAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func basicAlertWithCompletion(with title: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .cancel,handler: { action in
            completion()
        }))
                        
        present(alert, animated: true)
    }
    
    func addAlert(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        alert.addTextField { textField in
            textField.placeholder = "Task name"
        }
        
//        alert.addTextField { textField in
//            textField.placeholder = "Task body"
//        }
        
        let add = UIAlertAction(title: "Add", style: .default) { action in
            let name = alert.textFields?[0]
          //  let body = alert.textFields?[1]
            
            guard let name = name?.text else { return }
            if !name.isEmpty {
                //let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(name)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(add)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
        func setupHideKeyboardOnTap() {
            self.view.addGestureRecognizer(self.endEditingRecognizer())
            self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
        }

        /// Dismisses the keyboard from self.view
        private func endEditingRecognizer() -> UIGestureRecognizer {
            let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
            tap.cancelsTouchesInView = false
            return tap
        }
    
}
