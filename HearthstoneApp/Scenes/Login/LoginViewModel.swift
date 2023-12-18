//
//  LoginViewModel.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import Foundation


protocol LoginViewModelProtocol {
    func signInWith(loginRequest: LoginModel)
    func routeToSignUp()
}

class LoginViewModel: LoginViewModelProtocol {
    private let loginAccount: LoginAccountProtocol
    private weak var alertView: AlertView?
    private weak var loadingView: LoadingView?
    private let emailValidator: EmailValidatorProtocol
    private let coordinator: Coordinator
    
    init(loginAccount: LoginAccountProtocol,
         alertView: AlertView,
         emailValidator: EmailValidatorProtocol,
         coordinator: Coordinator,
         loadingView: LoadingView)
    {
        self.loginAccount = loginAccount
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.coordinator = coordinator
        self.loadingView = loadingView
    }
    
    func signInWith(loginRequest: LoginModel) {
        if let message = validateFields(loginRequest: loginRequest) {
            alertView?.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView?.isLoading(viewModel: LoadingViewModel(isLoading: true))
            loginAccount.signIn(with: loginRequest) { [weak self] isLogged, error in
                if isLogged {
                    self?.coordinator.eventOcurred(type: .pushToHome)
                } else {
                    self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Erro",
                                                                           message: "Algo inesperado aconteceu, tente novamente em instantes"))
                }
                self?.loadingView?.isLoading(viewModel: LoadingViewModel(isLoading: false))
            }
        }
    }
    
    func routeToSignUp() {
        coordinator.eventOcurred(type: .pushToSignUp)
    }
    
    private func validateFields(loginRequest: LoginModel) -> String? {
        if loginRequest.email == "" || loginRequest.email == nil {
            return "O campo de E-mail é obrigatório"
        } else if !emailValidator.isValid(email: loginRequest.email ?? "") {
            return "O campo de E-mail esta inválido"
        } else if loginRequest.password == "" || loginRequest.password == nil {
            return "O campo de Senha é obrigatório"
        } else { return nil }
    }
}
