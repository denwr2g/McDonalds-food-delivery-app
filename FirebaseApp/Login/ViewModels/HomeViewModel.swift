//
//  HomeViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 26/04/2022.
//

import Foundation

final class HomeViewModel {
    
    var onGoToLoginViewController: (() -> Void)?
    var onGoToRegisterViewController: (() -> Void)?
    
    func shouldGoToLoginViewController() {
        self.onGoToLoginViewController?()
    }
    
    func shouldGoToRegisterViewController() {
        self.onGoToRegisterViewController?()
    }
}
