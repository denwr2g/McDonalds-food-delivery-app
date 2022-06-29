//
//  User.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 02/05/2022.
//

import Foundation

struct UserDL: Identifiable {
    
    var id: String 
    var name: String
    var phone: Int 
    var textPhone: String {
        return "+371 \(self.phone)"
    }
    var address: String
    
    var respresentation: [String: Any] {
        
        var repres = [String : Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["adress"] = self.address
        
        return repres

    }
    
}
