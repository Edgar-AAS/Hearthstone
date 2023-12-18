//
//  SignUpBuilder.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 04/12/23.
//

import Foundation

class SignUpBuilder {
    static func build(coordinator: Coordinator) -> SignUpViewController {
        let authService = AuthService()
        let addAccount = AddAccount(authentication: authService)
        let viewController = SignUpViewController()
        let emailValidator = EmailValidator()
        let viewModel = SignUpViewModel(addAccount: addAccount,
                                        alertView: viewController,
                                        emailValidator: emailValidator,
                                        coordinator: coordinator)
        viewController.signUp = viewModel.registerUserWith
        viewController.goToLogin = viewModel.routeSignUpToLogin
        return viewController
    }
}
