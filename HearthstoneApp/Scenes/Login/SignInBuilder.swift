//
//  SignInBuilder.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 04/12/23.
//

import Foundation

class SignInBuilder {
    static func build(coordinator: Coordinator) -> LoginViewController {
        let authService: Authentication = AuthService()
        let loginAccount: LoginAccountProtocol = LoginAccount(authentication: authService)
        let emailValidator: EmailValidatorProtocol = EmailValidator()
        let viewController = LoginViewController()
        let viewModel: LoginViewModelProtocol = LoginViewModel(loginAccount: loginAccount,
                                       alertView: viewController,
                                       emailValidator: emailValidator,
                                       coordinator: coordinator,
                                       loadingView: viewController)
        viewController.viewModel = viewModel
        return viewController
    }
}
