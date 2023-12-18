//
//  Authentication.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 05/12/23.
//

import Foundation

protocol AuthenticationProtocol {
    func addAccount(with registerUserRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void)
    func loginAccount(with loginRequest: LoginModel, completion: @escaping (Result<Void, Error>) -> Void)
}
