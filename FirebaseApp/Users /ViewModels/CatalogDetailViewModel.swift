//
//  CatalogDetailViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 11/05/2022.
//

import Foundation

final class CatalogDetailViewModel {
    
    private let sizes = ["Small", "Medium", "Big"]
    
    var product: ProductDB?
    var count = 1
    var selectedIndex: Int = 0
    var onGoToCatalogViewController: (() -> Void)?

    init() {
        setProduct()
    }
    
    private func shouldGoToCatalogViewController() {
        self.onGoToCatalogViewController?()
    }

    func getPrice() -> Int {
        guard let product = product else { return 0 }
        
        switch (selectedIndex) {
        case 0: return Int(product.price)
        case 1: return Int(Double(product.price) * 2)
        case 2: return Int(Double(product.price) * 3)
        default: return 0
        }
    }
    
    func getCount(value: Int) -> Int {
        count = value
        return count
    }
    
    func setProduct(product: ProductDB? = nil) {
        self.product = product
    }
    
    func addPosition(_ position: Position) {
        CartManager.shared.addPosition(position)
        shouldGoToCatalogViewController()
    }
    

}
