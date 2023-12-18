//
//  EmailValidatorSpy.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 04/12/23.
//

import Foundation
@testable import HearthstoneApp

class EmailValidatorSpy: EmailValidatorProtocol {
    private (set)var isValid: Bool = true
    private (set)var email: String = ""
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func completeWithValidEmail() {
        isValid = true
    }
    
    func completeWithFailure() {
        isValid = false
    }
}
