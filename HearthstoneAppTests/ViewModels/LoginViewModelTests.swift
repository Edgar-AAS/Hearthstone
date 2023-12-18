//
//  LoginViewModelTests.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 04/12/23.
//

import XCTest
@testable import HearthstoneApp

final class LoginViewModelTests: XCTestCase {
    func test_signInWith_should_call_loginAccount_with_correct_data() {
        let loginAccountSpy = LoginAccountSpy()
        let sut = makeSut(loginAccountSpy: loginAccountSpy)
        let loginRequest = LoginModel(email: "any_email@gmail.com",
                                      password: "any_password")
        sut.signInWith(loginRequest: loginRequest)
        XCTAssertEqual(loginRequest, loginAccountSpy.dataShouldBeReturned)
    }
    
    func test_signIn_validationFails_if_emailIs_empty() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let loginRequest = LoginModel(email: "", password: "any_password")
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação",
                                                     message: "O campo de E-mail é obrigatório"))
            exp.fulfill()
        }
        sut.signInWith(loginRequest: loginRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_validationFails_if_email_is_nil() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let loginRequest = LoginModel(email: nil, password: "any_password")
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação",
                                                     message: "O campo de E-mail é obrigatório"))
            exp.fulfill()
        }
        sut.signInWith(loginRequest: loginRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_validationFails_if_password_is_empty() {
        let alertViewSpy = AlertViewSpy()
        let loginAccountSpy = LoginAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, loginAccountSpy: loginAccountSpy)
        
        let loginRequest = LoginModel(email: "any_email@gmail.com", password: "")
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação",
                                                     message: "O campo de Senha é obrigatório"))
            exp.fulfill()
        }
        sut.signInWith(loginRequest: loginRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_validationFails_if_password_is_nil() {
        let alertViewSpy = AlertViewSpy()
        let loginAccountSpy = LoginAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, loginAccountSpy: loginAccountSpy)
        
        let loginRequest = LoginModel(email: "any_email@gmail.com", password: nil)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação",
                                                     message: "O campo de Senha é obrigatório"))
            exp.fulfill()
        }
        sut.signInWith(loginRequest: loginRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_completes_with_alert_error_with_loginAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let loginAccountSpy = LoginAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, loginAccountSpy: loginAccountSpy)
        let loginRequest = LoginModel(email: "any_email@gmail.com", password: "any_password")
        let exp = expectation(description: "waiting")
        sut.signInWith(loginRequest: loginRequest)
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", 
                                                     message: "Algo inesperado aconteceu, tente novamente em instantes"))
            exp.fulfill()
        }
        loginAccountSpy.completeLoginWithFailure()
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_should_pass_correct_email_to_emailValidator() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy)
        let loginRequest = LoginModel(email: "any_email@gmail.com", password: "any_password")
        sut.signInWith(loginRequest: loginRequest)
        XCTAssertEqual(loginRequest.email, emailValidatorSpy.email)
    }
    
    func test_signIn_completes_with_validation_failure_if_email_validator_fails() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, emailValidatorSpy: emailValidatorSpy)
        let loginRequest = LoginModel(email: "invalidEmail@gmail.com", password: "any_password")
        emailValidatorSpy.completeWithFailure()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação",
                                                     message: "O campo de E-mail esta inválido"))
            exp.fulfill()
        }
        sut.signInWith(loginRequest: loginRequest)
        wait(for: [exp], timeout: 1)
    }
    
    func test_route_to_signUp_should_call_coordinator_with_push_to_signUp_event_call() {
        let alertViewSpy = AlertViewSpy()
        let coordinatorspy = MainCoordinatorSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, coordinatorspy: coordinatorspy)
        sut.routeToSignUp()
        XCTAssertEqual(coordinatorspy.methods, [.pushToSignUp])
    }
    
    func test_signIn_should_call_coordinator_with_pushToHome_if_loginAccountSucceeds() {
        let loginAccountSpy = LoginAccountSpy()
        let coordinatorSpy = MainCoordinatorSpy()
        let sut = makeSut(loginAccountSpy: loginAccountSpy, coordinatorspy: coordinatorSpy)
        sut.signInWith(loginRequest: LoginModel(email: "any_email@gmail.com", password: "any_password"))
        loginAccountSpy.completeLoginWithSuccess()
        XCTAssertEqual(coordinatorSpy.methods, [.pushToHome])
    }
    
    func test_login_should_show_loading_before_and_after_authentication() {
        let loginAccountSpy = LoginAccountSpy()
        let loadingViewSpy = LoadingViewSpy()
        let sut = makeSut(loginAccountSpy: loginAccountSpy, loadingViewSpy: loadingViewSpy)
        
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { (loadingViewModel) in
            XCTAssertEqual(loadingViewModel.isLoading, true)
            exp.fulfill()
        }
        
        sut.signInWith(loginRequest: LoginModel(email: "any_email@gmail.com", password: "any_password"))
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { (loadingViewModel) in
            XCTAssertEqual(loadingViewModel.isLoading, false)
            exp2.fulfill()
        }
        loginAccountSpy.completeLoginWithFailure()
        wait(for: [exp2], timeout: 1)
    }
}

extension LoginViewModelTests {
    func makeSut(alertViewSpy: AlertViewProtocol = AlertViewSpy(),
                 loginAccountSpy: LoginAccountProtocol = LoginAccountSpy(),
                 emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 coordinatorspy: Coordinator = MainCoordinatorSpy(),
                 loadingViewSpy: LoadingViewProtocol = LoadingViewSpy(), file: StaticString = #filePath, line: UInt = #line) -> LoginViewModel {
        let sut = LoginViewModel(loginAccount: loginAccountSpy,
                                 alertView: alertViewSpy,
                                 emailValidator: emailValidatorSpy,
                                 coordinator: coordinatorspy,
                                 loadingView: loadingViewSpy)
        
        checkMemoryLeak(for: alertViewSpy, file: file, line: line)
        checkMemoryLeak(for: loginAccountSpy, file: file, line: line)
        checkMemoryLeak(for: emailValidatorSpy, file: file, line: line)
        checkMemoryLeak(for: coordinatorspy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
