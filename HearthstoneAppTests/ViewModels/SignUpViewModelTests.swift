//
//  SignUpViewModelTests.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 01/12/23.
//

import XCTest
@testable import HearthstoneApp

final class SignUpViewModelTests: XCTestCase {
    func test_register_should_show_validation_error_message_if_username_is_empty() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let userRequest = RegisterUserRequest(username: "", email: "any_email@gmail.com", password: "any_password", passwordConfirmation: "any_password")
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { alertViewModel in
            XCTAssertEqual(alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo de Nome do usuário é obrigatório"))
            exp.fulfill()
        }
        sut.registerUserWith(userRequest: userRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_register_should_show_validation_error_message_if_email_is_empty() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let userRequest = RegisterUserRequest(username: "any_name", email: "", password: "any_password", passwordConfirmation: "password_confirmation")
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { alertViewModel in
            XCTAssertEqual(alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo de E-mail é obrigatório"))
            exp.fulfill()
        }
        sut.registerUserWith(userRequest: userRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_register_should_pass_correct_email_to_emailValidator() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy)
        let userRequest = RegisterUserRequest(username: "any_name", email: "any_email@gmail.com", password: "any_password", passwordConfirmation: "password_confirmation")
        sut.registerUserWith(userRequest: userRequest)
        XCTAssertEqual(userRequest.email, emailValidatorSpy.email)
    }
    
    func test_register_completes_with_validation_failure_if_email_validator_fails() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let viewModel = makeSut(alertViewSpy: alertViewSpy, emailValidatorSpy: emailValidatorSpy)
        let userRequest = RegisterUserRequest(username: "usename", email: "any_email@gmail.com", password: "password_confirmation", passwordConfirmation: "password_confirmation")
        emailValidatorSpy.completeWithFailure()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { alertViewModel in
            XCTAssertEqual(alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo de E-mail esta inválido"))
            exp.fulfill()
        }
        viewModel.registerUserWith(userRequest: userRequest)
        wait(for: [exp], timeout: 1)
    }

    func test_register_should_show_validation_error_message_if_password_is_empty() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let userRequest = RegisterUserRequest(username: "any_name", email: "any_email@gmail.com", password: "", passwordConfirmation: "password_confirmation")
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { alertViewModel in
            XCTAssertEqual(alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo de Senha é obrigatório"))
            exp.fulfill()
        }
        sut.registerUserWith(userRequest: userRequest)
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_register_should_show_validation_error_message_if_passwordConfirmation_is_empty() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let userRequest = RegisterUserRequest(username: "any_name", email: "any_email@gmail.com", password: "any_password", passwordConfirmation: "")
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { alertViewModel in
            XCTAssertEqual(alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo de Confirmação de senha é obrigatório"))
            exp.fulfill()
        }
        sut.registerUserWith(userRequest: userRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_register_should_show_validation_error_message_if_password_is_not_equal_passwordConfirmation() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let userRequest = RegisterUserRequest(username: "any_name", email: "any_email@gmail.com", password: "password1", passwordConfirmation: "password2")
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { alertViewModel in
            XCTAssertEqual(alertViewModel, AlertViewModel(title: "Falha na validação", message: "Não foi possível confirmar a senha"))
            exp.fulfill()
        }
        sut.registerUserWith(userRequest: userRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_register_should_pass_correctData_from_addAccount() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let userRequest = RegisterUserRequest(username: "any_name", email: "any_email@gmail.com", password: "password_confirmation", passwordConfirmation: "password_confirmation")
        sut.registerUserWith(userRequest: userRequest)
        XCTAssertEqual(userRequest, addAccountSpy.dataShouldBeReturned)
    }
    
    func test_routeSignUpToLogin_should_call_coordinator_with_popCurrentController_event() {
        let coordinatorSpy = MainCoordinatorSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountSpy: addAccountSpy, coordinatorSpy: coordinatorSpy)
        sut.registerUserWith(userRequest: makeRegisterUserRequest())
        addAccountSpy.completeSignUpWithSuccess()
        sut.routeSignUpToLogin()
        XCTAssertEqual(coordinatorSpy.methods, [.popCurrentController])
    }
    
    func test_register_should_show_error_message_if_addAccount_fails() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let userRequest = RegisterUserRequest(username: "usename", email: "any_email@gmail.com", password: "password_confirmation", passwordConfirmation: "password_confirmation")
        sut.registerUserWith(userRequest: userRequest)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { alertViewModel in
            XCTAssertEqual(alertViewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes"))
            exp.fulfill()
        }
        addAccountSpy.completeSignUpWithFailure()
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpViewModelTests {
    func makeSut(alertViewSpy: AlertView = AlertViewSpy(),
                 addAccountSpy:AddAccountProtocol = AddAccountSpy(),
                 emailValidatorSpy: EmailValidatorProtocol = EmailValidatorSpy(),
                 coordinatorSpy: Coordinator = MainCoordinatorSpy(), file: StaticString = #filePath, line: UInt = #line) -> SignUpViewModel
    {
        let sut = SignUpViewModel(addAccount: addAccountSpy,
                                  alertView: alertViewSpy,
                                  emailValidator: emailValidatorSpy,
                                  coordinator: coordinatorSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

