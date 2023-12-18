//
//  AddAccountProtocol.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 04/12/23.
//

import Foundation

protocol AddAccountProtocol: AnyObject {
    func signUp(with registerUserRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void)
}
