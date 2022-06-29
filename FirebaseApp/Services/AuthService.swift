//
//  AuthManager.swift
//  FirebaseApp
//
//  Created by deniss.lobacs on 02/05/2022.
//

import Foundation
import Firebase

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            print("Succesfully")
            // shouldGoToHomeViewController()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                
                let userDl = UserDL(id: result.user.uid, name: "", phone: 0, address: "")
                
                DatabaseService.shared.setUser(user: userDl) { resultDB in
                    switch (resultDB) {
                        
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
       
}

