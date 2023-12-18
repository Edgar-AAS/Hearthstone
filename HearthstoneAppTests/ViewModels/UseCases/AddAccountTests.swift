//
//  AddAccountTests.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 14/12/23.
//

import XCTest
@testable import HearthstoneApp

final class AddAccountTests: XCTestCase {
    func test_addAccount_should_call_authentication_with_correct_data() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy)
        let registerUserRequest = makeRegisterUserRequest()
        sut.signUp(with: registerUserRequest) { _, _ in }
        XCTAssertEqual(authenticationSpy.registerUserRequest, registerUserRequest)
    }
    
    func test_addAccount_completes_with_success_with_authentication_succeeds() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy)
        let registerUserRequest = makeRegisterUserRequest()
        let exp = expectation(description: "waiting")
       
        sut.signUp(with: registerUserRequest) { isRegistered, error in
            XCTAssertTrue(isRegistered)
            XCTAssertNil(error)
            exp.fulfill()
        }
        
        authenticationSpy.completeAddAccountWithSuccess()
        wait(for: [exp], timeout: 1)
    }
    
    func test_addAccount_completes_with_failure_with_authentication_fails() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy)
        let registerUserRequest = makeRegisterUserRequest()
        let exp = expectation(description: "waiting")
       
        sut.signUp(with: registerUserRequest) { isRegistered, error in
            XCTAssertFalse(isRegistered)
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        authenticationSpy.completeAddAccountWithFailure()
        wait(for: [exp], timeout: 1)
    }
    
    func test_addAccount_should_not_complete_if_sut_has_been_deallocated() {
        let authenticationSpy = AuthenticationSpy()
        var sut: AddAccount? = makeSut(authenticationSpy: authenticationSpy)
        var result1: Bool?
        var result2: Error?
        
        sut?.signUp(with: makeRegisterUserRequest()) {
            result1 = $0
            result2 = $1
        }
        
        sut = nil
        authenticationSpy.completeAddAccountWithFailure()
        XCTAssertNil(result1)
        XCTAssertNil(result2)
    }
}

extension AddAccountTests {
    func makeSut(authenticationSpy: AuthenticationSpy) -> AddAccount {
        let sut = AddAccount(authentication: authenticationSpy)
        checkMemoryLeak(for: sut)
        return sut
    }
}
