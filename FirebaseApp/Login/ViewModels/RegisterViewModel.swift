//
//  RegisterViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 27/04/2022.
//

import Foundation
import UIKit
import Firebase

final class RegisterViewModel {
    
    var onGoToMainViewController: (() -> Void)?
    var onGoToHomeViewController: (() -> Void)?
    var onLoadingSpinnerAppear: (() -> Void)?
    var onLoadingSpinnerDisappear: (() -> Void)?
    
    func shouldGoHomeViewController() {
        self.onGoToHomeViewController?()
    }
    
    private func shouldGoToMainViewController() {
        self.onGoToMainViewController?()
    }
    
    private func shouldLoadingSpinnerAppear() {
        self.onLoadingSpinnerAppear?()
    }
    
    private func shouldLoadingSpinnerDisappear() {
        self.onLoadingSpinnerDisappear?()
    }
    
    func signUp(email: String, password: String) {
        
        shouldLoadingSpinnerAppear()

        AuthService.shared.signUp(email: email, password: password) { result in
            switch(result) {
                
            case .success(_):
                self.shouldGoToMainViewController()
            case .failure(let error):
                print("Registration error, \(error.localizedDescription)")
                self.shouldLoadingSpinnerDisappear()
            }
        }
    }
    
}
