//
//  AddAccountSpy.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 03/12/23.
//

import Foundation
@testable import HearthstoneApp

class AddAccountSpy: AddAccountProtocol {
    private (set) var dataShouldBeReturned: RegisterUserRequest?
    private (set) var emit: ((Bool, Error?) -> Void)?
    
    func signUp(with registerUserRequest: HearthstoneApp.RegisterUserRequest,
                completion: @escaping (Bool, Error?) -> Void) {
        dataShouldBeReturned = registerUserRequest
        emit = completion
    }
    
    func completeSignUpWithSuccess() {
        emit?(true, nil)
    }
    
    func completeSignUpWithFailure() {
        emit?(false,  nil)
    }
}
