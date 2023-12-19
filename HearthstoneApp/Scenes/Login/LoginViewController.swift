//
//  LoginViewController.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import UIKit

class LoginViewController: UIViewController {
    private lazy var customView: LoginScreen? = {
        return view as? LoginScreen
    }()
    
    var viewModel: LoginViewModelProtocol?
    
    override func loadView() {
        super.loadView()
        view = LoginScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        customView?.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        customView?.goToRegisterButton.addTarget(self, action: #selector(goToRegisterButtonTapped), for: .touchUpInside)
    }
    
    @objc private func goToRegisterButtonTapped() {
        viewModel?.routeToSignUp()
    }
    
    @objc private func loginButtonTapped() {
        if let email = customView?.emailTextField.text,
           let password = customView?.passwordTextField.text {
            
            let loginRequest = LoginModel(email: email, password: password)
            viewModel?.signInWith(loginRequest: loginRequest)
        }
    }
}

extension LoginViewController: LoadingViewProtocol {
    func isLoading(viewModel: LoadingViewModel) {
        customView?.animateLoading(isLoading: viewModel.isLoading)
        viewModel.isLoading ? disableView() : enableView()
    }
}

extension LoginViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        showAlert(title: viewModel.title, message: viewModel.message)
    }
}
