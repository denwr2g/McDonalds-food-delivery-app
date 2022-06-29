//
//  CartViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 23/05/2022.
//

import Foundation

final class CartViewModel {
    
    var onUpdateTable: (() -> Void)?
    var onShowSuccessfullyAlert: (() -> Void)?
    var onShowErrorAlert: (() -> Void)?
    var onShowOrderSheet: ( () -> Void)?
    var onDisableButton: (() -> Void)?
    var onEnableButton: (() -> Void)?
    
    private func shouldUpdateTable() {
        self.onUpdateTable?()
    }
    
    private func shouldDisableButton() {
        self.onDisableButton?()
    }
    
    private func shouldEnableButton() {
        self.onEnableButton?()
    }
    
    private func shouldShowSuccessfullyAlert() {
        self.onShowSuccessfullyAlert?()
    }
    
    private func shouldShowOrderSheet() {
        self.onShowOrderSheet?()
    }
    
    func makeOrderTapped() {
        
        if CartManager.shared.positions.isEmpty {
            shouldShowErrorAlert()
        } else {
            shouldShowOrderSheet()
        }
    }
    
    private func shouldShowErrorAlert() {
        self.onShowErrorAlert?()
        return
    }
    
    func getValue(index: Int) -> Position? {
        CartManager.shared.getPosition(index: index)
    }
    
    func getPositionsCount() -> Int {
        CartManager.shared.positions.count
    }
    
    func getTotalCost() -> String {
        return "\(CartManager.shared.getTotalCost()) $"
    }
    
    func removePosition(index: Int) {
        CartManager.shared.removePosition(index: index)
    }
    
    func getPositions() -> [Position] {
        CartManager.shared.positions
    }
    
    func makeOrder() {
                
        var order = Order(userID: AuthService.shared.currentUser!.uid ,
                          date: Date(),
                          status: OrderStatus.new.rawValue)
        
        order.positions = CartManager.shared.positions
        
        shouldDisableButton()
        
        DatabaseService.shared.setOrder(order: order) { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let order):
                print(order.cost)
                self.shouldDisableButton()
                self.shouldShowSuccessfullyAlert()
                self.clearCart()
                self.shouldEnableButton()
            case .failure(_):
                print("Order error")
                self.shouldEnableButton()
            }
        }
        
    }
    
    func clearCart() {
        CartManager.shared.removePositions()
        shouldUpdateTable()
    }
    
}

