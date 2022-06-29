//
//  ProductDB.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 22/06/2022.
//

import Foundation
import FirebaseFirestore

struct ProductDB {
    var id: String = UUID().uuidString
    var title: String
    var price: Int
    var priceStr: String {
        return "\(self.price) $"
    }
    var descript: String
    var imgUrl: String
    var isCountable: Bool
    var category: String
    
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        
        repres["id"] = id
        repres["title"] = title
        repres["price"] = price
        repres["descript"] = descript
        repres["imgUrl"] = imgUrl
        repres["isCountable"] = isCountable
        repres["category"] = category

        return repres
    }
    
    init(id: String = UUID().uuidString,
         title: String,
         price: Int,
         descript: String,
         imgUrl: String,
         isCountable: Bool,
         category: String) {
        
        self.id = id
        self.title = title
        self.price = price
        self.descript = descript
        self.imgUrl = imgUrl
        self.isCountable = isCountable
        self.category = category
    }
    
    init?(doc: QueryDocumentSnapshot) {
        
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let descript = data["descript"] as? String else { return nil }
        guard let imgUrl = data["imgUrl"] as? String else { return nil }
        guard let isCountable = data["isCountable"] as? Bool else { return nil }
        guard let category = data["category"] as? String else { return nil }


        self.id = id
        self.title = title
        self.price = price
        self.descript = descript
        self.imgUrl = imgUrl
        self.isCountable = isCountable
        self.category = category
    }
}

