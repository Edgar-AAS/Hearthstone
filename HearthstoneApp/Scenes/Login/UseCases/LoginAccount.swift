//
//  LoginAccount.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 04/12/23.
//

import Foundation

class LoginAccount: LoginAccountProtocol {
    private let authentication: AuthenticationProtocol
    
    init(authentication: AuthenticationProtocol) {
        self.authentication = authentication
    }
    
    func signIn(with loginRequest: LoginModel, completion: @escaping (Bool, Error?) -> Void) {
        authentication.loginAccount(with: loginRequest) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(): completion(true, nil)
                case .failure(let error): completion(false, error)
            }
        }
    }
}
