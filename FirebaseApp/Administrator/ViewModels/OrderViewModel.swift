//
//  OrderViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 27/05/2022.
//

import Foundation

final class OrderViewModel {
    
    var currentOrder: Order?
    var onUpdateAdminTable: (() -> Void)?
    
    var statuses: [String] {
        var sts = [String]()
        
        for status in OrderStatus.allCases {
            sts.append(status.rawValue)
        }
        return sts
    }
    
    init() {
        setCurrentOrder()
    }
    
    func shouldUpdateAdminTable() {
        self.onUpdateAdminTable?()
    }
    
    func getUserData(completion: @escaping (Result<UserDL, Error>) -> Void) {
        guard let id = currentOrder?.userID else { return }
        
        DatabaseService.shared.getProfile(by: id) { result in
            switch(result) {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateStatus(with status: String) {
        guard let currentOrder = currentOrder else { return }
        DatabaseService.shared.updateStatus(order: currentOrder, status: status)
        shouldUpdateAdminTable()
    }
    
    func setCurrentOrder(with order: Order? = nil) {
        self.currentOrder = order
    }
    
    func getValue(index: Int) -> Position? {
        guard let positions = currentOrder?.positions else { return nil }
        guard positions.count > index else { return nil }
        return positions[index]
    }
    
    func getPositionsCount() -> Int? {
        return currentOrder?.positions.count
    }
}
