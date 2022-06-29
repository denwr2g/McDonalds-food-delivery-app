//
//  AdminViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 27/05/2022.
//

import Foundation

final class AdminViewModel {
    
    var orders: [Order] = [Order]()
    var onGoToHomeViewController: (() -> Void)?
    var onGoToOrderViewController: ((Order) -> Void)?
    var onGoToProductstViewController: (() -> Void)?
    var onGoToNewProductViewController: (() -> Void)?
    var onUpdateTable: (() -> Void)?
    
    var onStartIndicator: (() -> Void)?
    var onStopIndicator: (() -> Void)?
    var onShowMessage: (() -> Void)?
    var onHideMessage: (() -> Void)?
    
    init() {
        getOrders()
    }
    
    func shouldGoToProductsViewController() {
        self.onGoToProductstViewController?()
    }
    
    func shouldGoToNewProductViewController() {
        self.onGoToNewProductViewController?()
    }
    
    func shouldGoToOrderViewController(with order: Order) {
        self.onGoToOrderViewController?(order)
    }
    
    private func shouldStartIndicator() {
        self.onStartIndicator?()
    }
    
    private func shouldStopIndicator() {
        self.onStopIndicator?()
    }
    
    private func shouldShowMessage() {
        self.onShowMessage?()
    }
    
    private func shouldHideMessage() {
        self.onHideMessage?()
    }
    
    private func shouldUpdateTable() {
        self.onUpdateTable?()
    }
    
    func getOrders() {
        
        shouldStartIndicator()
        shouldHideMessage()

        DatabaseService.shared.getOrders(by: nil) { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let orders):
                self.orders = orders
                
                if orders.isEmpty {
                    self.shouldShowMessage()
                    self.shouldStopIndicator()
                }
                
                for (index, order) in orders.enumerated() {
                    DatabaseService.shared.getPositions(by: order.id) { [weak self] result in
                        guard let self = self else { return }

                        switch(result) {
                        case .success(let positions):
                            self.orders[index].positions = positions
                            self.shouldUpdateTable()
                            self.shouldStopIndicator()
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.shouldStopIndicator()
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.shouldStopIndicator()
            }
        }
    }
    
    func getValue(index: Int) -> Order? {
        guard orders.count > index else { return nil }
        return orders[index]
    }
    
    func getOrdersCount() -> Int {
        return orders.count
    }

    func shouldGoToHomeViewController() {
        self.onGoToHomeViewController?()
    }
    
    func logOut() {
        AuthService.shared.logOut()
        shouldGoToHomeViewController()
    }
    
}
