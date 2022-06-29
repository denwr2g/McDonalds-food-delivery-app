//
//  LoginViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 28/04/2022.
//

import Foundation
import Firebase

final class LoginViewModel {
    
    var onGoToMainViewController: (() -> Void)?
    var onGoToAdminViewController: (() -> Void)?
    var onGoToHomeViewController: (() -> Void)?
    var onShowErrorAlert: (() -> Void)?
    var onLoadingSpinnerAppear: (() -> Void)?
    var onLoadingSpinnerDisappear: (() -> Void)?


    func shouldGoHomeViewController() {
        self.onGoToHomeViewController?()
    }
    
    private func shouldGoToMainViewController() {
        self.onGoToMainViewController?()
    }
    
    private func shouldGoToAdminViewController() {
        self.onGoToAdminViewController?()
    }
    
    private func shouldShowErrorAlert() {
        self.onShowErrorAlert?()
    }
    
    private func shouldLoadingSpinnerAppear() {
        self.onLoadingSpinnerAppear?()
    }
    
    private func shouldLoadingSpinnerDisappear() {
        self.onLoadingSpinnerDisappear?()
    }
    
    private func checkIfAdmin() {
        if let user = AuthService.shared.currentUser {
            if user.uid == "aWUFWxiABOhrCiEaWquJTkEBrNU2" {
                shouldGoToAdminViewController()
            } else {
                shouldGoToMainViewController()
            }
        }
    }
    
    func signIn(email: String, password: String) {
        
        shouldLoadingSpinnerAppear()
        
        AuthService.shared.signIn(email: email, password: password) { result in
            
            switch(result) {
            case .success(_):
                self.checkIfAdmin()
            case .failure(_):
                self.shouldShowErrorAlert()
                self.shouldLoadingSpinnerDisappear()
            }
        }
    }
    
}
