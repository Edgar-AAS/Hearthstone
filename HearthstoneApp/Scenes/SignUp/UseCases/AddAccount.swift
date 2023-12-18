//
//  AddAccount.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import Foundation

class AddAccount: AddAccountProtocol {
    private let authentication: AuthenticationProtocol
    
    init(authentication: AuthenticationProtocol) {
        self.authentication = authentication
    }
    
    func signUp(with registerUserRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        authentication.addAccount(with: registerUserRequest) { [weak self] isRegistered, error in
            guard self != nil else { return }
            isRegistered ? completion(true, nil) : completion(false, error)
        }
    }
}
