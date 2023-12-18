//
//  AuthService.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class AuthService: AuthenticationProtocol {
    func loginAccount(with loginRequest: LoginModel, completion: @escaping (Result<Void, Error>) -> Void) {
        if let email = loginRequest.email,
           let password = loginRequest.password {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    func addAccount(with registerUserRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        if  let username = registerUserRequest.username,
            let email = registerUserRequest.email,
            let password = registerUserRequest.password {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                guard let resultUser = result?.user else {
                    completion(false, error)
                    return
                }
                
                let database = Firestore.firestore()
                database.collection("users")
                    .document(resultUser.uid)
                    .setData([
                        "username": username,
                        "email": email,
                        "password": password
                    ])
                completion(true, nil)
            }
        }
    }
}

