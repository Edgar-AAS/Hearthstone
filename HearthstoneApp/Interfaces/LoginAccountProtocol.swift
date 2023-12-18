//
//  LoginAccountProtocol.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 04/12/23.
//

import Foundation

protocol LoginAccountProtocol: AnyObject {
    func signIn(with loginRequest: LoginModel, completion: @escaping (Bool, Error?) -> Void)
}
