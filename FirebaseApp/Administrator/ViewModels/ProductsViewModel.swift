//
//  ProductsViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 22/06/2022.
//

import Foundation

final class ProductsViewModel {
    
    var products: [ProductDB] = [ProductDB]()
    var onUpdateTable: (() -> Void)?
    var onStartIndicator: (() -> Void)?
    var onStopIndicator: (() -> Void)?
    var onGoToBack: (() -> Void)?

    init() {
        getProducts()
    }
    
    func shouldGoBack() {
        self.onGoToBack?()
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
    
    func getProducts() {
        
        shouldStartIndicator()

        ProductService.shared.getProducts { result in
            switch result {
                
            case .success(let products):
                self.products = products
                self.shouldUpdateTable()
                self.shouldStopIndicator()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getValue(index: Int) -> ProductDB? {
        guard products.count > index else { return nil }
        return products[index]
    }
    
    func getProductsCount(where category: String) -> Int {
        
        var sum = 0
        
        for product in products {
            if product.category == category {
                sum += 1
            }
        }
        return sum
    }
    
    func getValue(where category: String, index: Int) -> ProductDB? {
        
        var products2: [ProductDB] = []
        
        for product in products {
            if product.category == category {
                products2.append(product)
            }
        }
        guard products2.count > index else { return nil }
        return products2[index]
    }
    
    func numberOfSection(index: Int) -> Int {
        return index == 0 ? 6 : 1
    }
    
    func numberOfRowInSection(index: Int, section: Int) -> Int {
        
        switch index {
        case 0:
            switch section {
            case 0: return getProductsCount(where: "Breakfast")
            case 1: return getProductsCount(where: "Burgers")
            case 2: return getProductsCount(where: "Desserts")
            case 3: return getProductsCount(where: "Finger Food")
            case 4: return getProductsCount(where: "Fries")
            case 5: return getProductsCount(where: "Sauces")
            default: return 0
                
            }
        case 1: return getProductsCount(where: "Breakfast")
        case 2: return getProductsCount(where: "Burgers")
        case 3: return getProductsCount(where: "Desserts")
        case 4: return getProductsCount(where: "Finger Food")
        case 5: return getProductsCount(where: "Fries")
        case 6: return getProductsCount(where: "Sauces")
            
        default: return 0
        }
    }
    
    func getValue(currentIndex: Int, section: Int, row: Int) -> ProductDB? {
                
        switch currentIndex {
        case 0:
            switch section {
            case 0: return getValue(where: "Breakfast", index: row)
            case 1: return getValue(where: "Burgers", index: row)
            case 2: return getValue(where: "Desserts", index: row)
            case 3: return getValue(where: "Finger Food", index: row)
            case 4: return getValue(where: "Fries", index: row)
            case 5: return getValue(where: "Sauces", index: row)
            default: return nil
            }
        case 1: return getValue(where: "Breakfast", index: row)
        case 2: return getValue(where: "Burgers", index: row)
        case 3: return getValue(where: "Desserts", index: row)
        case 4: return getValue(where: "Finger Food", index: row)
        case 5: return getValue(where: "Fries", index: row)
        case 6: return getValue(where: "Sauces", index: row)
            
        default: return nil
        }
        
    }
    
    func viewForHeaderInSection(index: Int, section: Int) -> String {
        switch index {
        case 0:
            switch section {
            case 0: return "Breakfast"
            case 1: return "Burgers"
            case 2: return "Desserts"
            case 3: return "Finger Foods"
            case 4: return "Fries"
            case 5: return "Sauces"
            default: return ""
            }
        case 1: return "Breakfast"
        case 2: return "Burgers"
        case 3: return "Desserts"
        case 4: return "Finger Foods"
        case 5: return "Fries"
        case 6: return "Sauces"
        default: return ""
        }
    }
    
}
