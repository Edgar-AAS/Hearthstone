//
//  LoginAccountSpy.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 04/12/23.
//

import Foundation
@testable import HearthstoneApp

class LoginAccountSpy: LoginAccountProtocol {
    private (set)var dataShouldBeReturned: LoginModel?
    private (set)var emit: ((Bool, Error?) -> Void)?
    
    func signIn(with loginRequest: HearthstoneApp.LoginModel, completion: @escaping (Bool, Error?) -> Void) {
        self.dataShouldBeReturned = loginRequest
        emit = completion
    }
    
    func completeLoginWithSuccess() {
        emit?(true, nil)
    }
    
    func completeLoginWithFailure() {
        emit?(false, makeError())
    }
}
