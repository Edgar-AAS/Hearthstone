//
//  RegisterUserRequest.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.

import Foundation

struct RegisterUserRequest: Equatable {
    var username: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}
