//
//  NewProductViewModel.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 22/06/2022.
//

import Foundation

final class NewProductViewModel {
    
    var onShowSuccesfullAlert: (() -> Void)?
    
    private func shouldShowSuccesfullAlert() {
        self.onShowSuccesfullAlert?()
    }
    
    func addProduct(product: ProductDB) {
        ProductService.shared.setProduct(product: product) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(_):
                self.shouldShowSuccesfullAlert()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
