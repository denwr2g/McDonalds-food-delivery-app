//
//  CartManager.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 23/05/2022.
//

import Foundation

class CartManager {
    
    static let shared = CartManager()
    
    private init() {}
    
    var positions = [Position]()
    
    var cost: Int {
        
        var sum = 0
        
        for position in positions {
            sum += position.cost
        }
        
        return sum
    }
    
    func getTotalCost() -> Int {
        return cost
    }
    
    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
    
    func removePosition(index: Int) {
        self.positions.remove(at: index)
    }
    
    func getPosition(index: Int) -> Position? {
        guard positions.count > index else { return nil }
        return positions[index]
    }
    
    func removePositions() {
        self.positions = []
    }
    
    func checkIfCartIsEmpty() -> Bool {
        if positions.isEmpty {
            return true
        } else {
            return false
        }
    }
}
