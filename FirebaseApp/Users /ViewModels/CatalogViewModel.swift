//
//  CatalogViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 09/05/2022.
//

import Foundation

final class CatalogViewModel {
    
    var products: [ProductDB] = [ProductDB]()
    
    var onUpdateTable: (() -> Void)?
    var onGoToHomeViewController: (() -> Void)?
    var onOpenCatalogDetailViewController: ((ProductDB) -> Void)?
    var onStartIndicator: (() -> Void)?
    var onStopIndicator: (() -> Void)?
    
    
    init() {
        getProducts()
    }
    
    func shouldOpenCatalogDetailViewController(with product: ProductDB) {
        self.onOpenCatalogDetailViewController?(product)
    }
    
    private func shouldGoToHomeViewController() {
        self.onGoToHomeViewController?()
    }
    
    private func shouldStartIndicator() {
        self.onStartIndicator?()
    }
    
    private func shouldStopIndicator() {
        self.onStopIndicator?()
    }
    
    private func shouldUpdateTable() {
        self.onUpdateTable?()
    }
    
    func logOut() {
        AuthService.shared.logOut()
        shouldGoToHomeViewController()
    }
    
    private func getProducts() {
        
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
    
    private func getProductsCount(where category: String) -> Int {
        
        var count = 0
        
        for product in products {
            if product.category == category {
                count += 1
            }
        }
        return count
    }
    
    private func getValue(where category: String, index: Int) -> ProductDB? {
        
        var products: [ProductDB] = []
        
        for product in self.products {
            if product.category == category {
                products.append(product)
            }
        }
        
        guard products.count > index else { return nil }
        
        return products[index]
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
    
    
    func didSelectRowAt(currentIndex: Int, section: Int, row: Int) {
        
        switch currentIndex {
        case 0:
            switch section {
            case 0:
                guard let product = getValue(where: "Breakfast", index: row) else { return }
                shouldOpenCatalogDetailViewController(with: product)
            case 1:
                guard let product = getValue(where: "Burgers", index: row) else { return }
                shouldOpenCatalogDetailViewController(with: product)
            case 2:
                guard let product = getValue(where: "Desserts", index: row) else { return }
                shouldOpenCatalogDetailViewController(with: product)
            case 3:
                guard let product = getValue(where: "Finger Food", index: row) else { return }
                shouldOpenCatalogDetailViewController(with: product)
            case 4:
                guard let product = getValue(where: "Fries", index: row) else { return }
                shouldOpenCatalogDetailViewController(with: product)
            case 5:
                guard let product = getValue(where: "Sauces", index: row) else { return }
                shouldOpenCatalogDetailViewController(with: product)
            default:
                break
            }
        case 1:
            guard let product = getValue(where: "Breakfast", index: row) else { return }
            shouldOpenCatalogDetailViewController(with: product)
        case 2:
            guard let product = getValue(where: "Burgers", index: row) else { return }
            shouldOpenCatalogDetailViewController(with: product)
        case 3:
            guard let product = getValue(where: "Desserts", index: row) else { return }
            shouldOpenCatalogDetailViewController(with: product)
        case 4:
            guard let product = getValue(where: "Finger Food", index: row) else { return }
            shouldOpenCatalogDetailViewController(with: product)
        case 5:
            guard let product = getValue(where: "Fries", index: row) else { return }
            shouldOpenCatalogDetailViewController(with: product)
        case 6:
            guard let product = getValue(where: "Sauces", index: row) else { return }
            shouldOpenCatalogDetailViewController(with: product)
        default:
            break
        }
    }
    
}
