//
//  SignUpViewModelProtocol.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 18/12/23.
//

import Foundation

protocol SignUpViewModelProtocol {
    func registerUserWith(userRequest: RegisterUserRequest)
    func routeSignUpToLogin()
}
