//
//  Positions.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 23/05/2022.
//

import Foundation
import FirebaseFirestore

struct Position {
    
    var id: String
    var product: ProductDB
    var count: Int
    
    var cost: Int {
        return product.price * self.count
    }
    
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        
        repres["id"] = id
        repres["count"] = count
        repres["title"] = product.title
        repres["price"] = product.price
        repres["cost"] = cost
        
        return repres
    }
    
    internal init(id: String, product: ProductDB, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }
    
    init?(doc: QueryDocumentSnapshot) {
        
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }

     //   let product: ProductDB = Product(id: "", imgUrl: "", title: title, price: price, descript: "")
        let product: ProductDB = ProductDB(id: "", title: title, price: price, descript: "", imgUrl: "", isCountable: false, category: "")

        guard let count = data["count"] as? Int else { return nil }
        
        self.id = id
        self.product = product
        self.count = count
    }
}
