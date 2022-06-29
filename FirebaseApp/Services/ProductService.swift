//
//  ProductService.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 22/06/2022.
//

import Foundation
import FirebaseFirestore

class ProductService {
    
    static let shared = ProductService()
    
    private init() {}
    
    private let db = Firestore.firestore()
    
    private var productsRef: CollectionReference {
        return db.collection("products")
    }
    
    func setProduct(product: ProductDB, completion: @escaping (Result<ProductDB, Error>) -> Void) {
        
        productsRef.document(product.id).setData(product.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(product))
            }
        }
    }
    
    func getProducts(completion: @escaping (Result<[ProductDB], Error>) -> Void) {
        
        productsRef.getDocuments { qSnap, error in
            
            if let qSnap = qSnap {
                var products = [ProductDB]()
                for doc in qSnap.documents {
                    if let product = ProductDB(doc: doc) {
                        products.append(product)
                    }
                }
                completion(.success(products))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
    }
    
    func getProducts(where category: String, completion: @escaping (Result<[ProductDB], Error>) -> Void) {
        
        productsRef.getDocuments { qSnap, error in
            
            if let qSnap = qSnap {
                var products = [ProductDB]()
                for doc in qSnap.documents {
                    if let product = ProductDB(doc: doc) {
                        
                        if product.category == category {
                            products.append(product)
                        }
                    }
                }
                completion(.success(products))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
    }
}
