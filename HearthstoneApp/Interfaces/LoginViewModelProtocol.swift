//
//  LoginViewModelProtocol.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 18/12/23.
//

import Foundation

protocol LoginViewModelProtocol {
    func signInWith(loginRequest: LoginModel)
    func routeToSignUp()
}
