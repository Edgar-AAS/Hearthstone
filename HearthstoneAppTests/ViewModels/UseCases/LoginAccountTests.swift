//
//  LoginAccountTests.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 13/12/23.
//

import XCTest
@testable import HearthstoneApp

final class LoginAccountTests: XCTestCase {
    func test_signIn_should_call_loginAccount_with_correct_data() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy)
        sut.signIn(with: makeLoginModel()) { _, _ in }
        XCTAssertEqual(authenticationSpy.loginModel, makeLoginModel())
    }
    
    func test_signIn_with_authentication_succeeds() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy)
        let exp = expectation(description: "waiting")
        sut.signIn(with: makeLoginModel()) { isRegistered, error in
            XCTAssertTrue(isRegistered)
            XCTAssertNil(error)
            exp.fulfill()
        }
        authenticationSpy.completeLoginAccountWithSuccess()
        wait(for: [exp], timeout: 1)
    }
    
    func test_loginAccount_should_not_complete_if_sut_has_been_deallocated() {
        let authenticationSpy = AuthenticationSpy()
        var sut: LoginAccount? = makeSut(authenticationSpy: authenticationSpy)
        var result1: Bool?
        var result2: Error?

        sut?.signIn(with: makeLoginModel()) {
            result1 = $0
            result2 = $1
        }
        
        sut = nil
        authenticationSpy.completeLoginAccountWithError()
        XCTAssertNil(result1)
        XCTAssertNil(result2)
    }
    
    func test_signIn_with_authentication_failure() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy)
        let exp = expectation(description: "waiting")
        sut.signIn(with: makeLoginModel()) { isRegistered, error in
            XCTAssertFalse(isRegistered)
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        authenticationSpy.completeLoginAccountWithError()
        wait(for: [exp], timeout: 1)
    }
}

extension LoginAccountTests {
    func makeSut(authenticationSpy: AuthenticationSpy) -> LoginAccount {
        let sut = LoginAccount(authentication: authenticationSpy)
        checkMemoryLeak(for: sut)
        return sut
    }
}
