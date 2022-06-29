//
//  ProfileViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 03/05/2022.
//

import Foundation

final class ProfileViewModel {
    
    var profile: UserDL?
    var orders: [Order] = [Order]()
    
    var onUpdateTable: (() -> Void)?

    var onStartIndicator: (() -> Void)?
    var onStopIndicator: (() -> Void)?
    var onShowMessage: (() -> Void)?
    var onHideMessage: (() -> Void)?
    var onShowAlert: (() -> Void)?
    
    init() {
        getProfile()
        getOrders()
    }
    
    private func shouldUpdateTable() {
        self.onUpdateTable?()
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
    
    private func shouldShowAlert() {
        self.onShowAlert?()
    }
    
    private func getProfile() {
        DatabaseService.shared.getProfile { result in
            switch (result) {
                
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getOrders() {
        
        shouldStartIndicator()
        shouldHideMessage()
        
        DatabaseService.shared.getOrders(by: AuthService.shared.currentUser!.uid) { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let orders):
                self.orders = orders
                
                if orders.isEmpty {
                    self.shouldShowMessage()
                    self.shouldStopIndicator()
                }

                for (index, order) in orders.enumerated() {
                    DatabaseService.shared.getPositions(by: order.id) { result in
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
                
                print("Total: \(orders.count)")
            case .failure(let error):
                self.orders = []
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
    
    func updateProfile(name: String, address: String, phone: Int) {
        DatabaseService.shared.updateProfile(name: name, address: address, phone: phone)
        shouldShowAlert()
    }
}
