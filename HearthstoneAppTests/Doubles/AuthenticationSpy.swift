//
//  AuthenticationSpy.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 13/12/23.
//

import Foundation
@testable import HearthstoneApp

class AuthenticationSpy: AuthenticationProtocol {
    private (set) var loginModel: LoginModel?
    private (set) var registerUserRequest: RegisterUserRequest?
    
    var loginAccountEmit: ((Result<Void, Error>) -> Void)?
    var addAccountEmit: ((Bool, Error?) -> Void)?
    
    func loginAccount(with loginRequest: HearthstoneApp.LoginModel, completion: @escaping (Result<Void, Error>) -> Void) {
        self.loginModel = loginRequest
        self.loginAccountEmit = completion
    }
    
    func addAccount(with registerUserRequest: HearthstoneApp.RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        self.registerUserRequest = registerUserRequest
        self.addAccountEmit = completion
    }
    
    func completeAddAccountWithSuccess() {
        addAccountEmit?(true, nil)
    }
    
    func completeAddAccountWithFailure() {
        addAccountEmit?(false, makeError())
    }
    
    func completeLoginAccountWithSuccess() {
        loginAccountEmit?(.success(()))
    }
    
    func completeLoginAccountWithError() {
        loginAccountEmit?(.failure(makeError()))
    }
}
