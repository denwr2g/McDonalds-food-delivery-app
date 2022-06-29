//
//  OrderStatus.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 24/05/2022.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "New"
    case cooking = "Cooking"
    case delivering = "Delivering"
    case completed = "Completed"
    case cancelled = "Cancelled"
}

