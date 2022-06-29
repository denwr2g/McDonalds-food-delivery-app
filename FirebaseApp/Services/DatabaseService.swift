//
//  DatabaseManager.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 02/05/2022.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private var ordersRef: CollectionReference {
        return db.collection("orders")
    }
    
    private init() {}
    
    func getPositions(by orderID: String,
                      completion: @escaping (Result<[Position], Error>) -> Void) {
        
        let positionsRef = ordersRef.document(orderID).collection("positions")
        
        positionsRef.getDocuments { qSnap, error in
            if let querySnapshot = qSnap {
                var positions = [Position]()
                
                for doc in querySnapshot.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getOrders(by userID: String?,
                   completion: @escaping (Result<[Order], Error>) -> Void) {
        
        ordersRef.order(by: "date", descending: true).getDocuments { qSnap, error in
            
            
            if let qSnap = qSnap {
                var orders = [Order]()
                for doc in qSnap.documents {
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else { // Admin branch
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func setOrder(order: Order,
                  completion: @escaping (Result<Order, Error>) -> Void) {
        
        ordersRef.document(order.id).setData(order.representation) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPositions(to: order.id,
                                  positions: order.positions) { result in
                    switch(result) {
                    case .success(let positions):
                        print(positions.count)
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func setPositions(to orderId: String,
                      positions: [Position] ,
                      completion: @escaping (Result<[Position], Error>) -> Void ) {
        
        let positionsRef = ordersRef.document(orderId).collection("positions")
        
        for position in positions {
            positionsRef.document(position.id).setData(position.representation)
        }
        
        completion(.success(positions))
    }
    
    func setUser(user: UserDL, completion: @escaping (Result<UserDL, Error>) -> Void) {
        
        usersRef.document(user.id).setData(user.respresentation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func updateProfile(name: String, address: String, phone: Int) {
        
        usersRef.document(AuthService.shared.currentUser!.uid).updateData([
            K.User.nameField: name,
            K.User.addressField: address,
            K.User.phoneField: phone
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func updateStatus(order: Order, status: String) {
        
        ordersRef.document(order.id).updateData([
            "status": status
        ]) { err in
            if let err = err {
                print("Error status updating: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func getProfile(by userID: String? = nil, completion: @escaping (Result<UserDL, Error>) -> Void) {
        
        usersRef.document(userID != nil ? userID! : AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            
            guard let snapshot = docSnapshot else { return }
            guard let data = snapshot.data() else { return }
            guard let id = data[K.User.idField] as? String else { return }
            guard let userName = data[K.User.nameField] as? String else { return }
            guard let phone = data[K.User.phoneField] as? Int else { return }
            guard let address = data[K.User.addressField] as? String else { return }
            
            let user = UserDL(id: id, name: userName, phone: phone, address: address)
            
            completion(.success(user))
            
        }
    }
    
    
    
}
