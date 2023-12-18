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

extension LoginViewController: LoadingView {
    func isLoading(viewModel: LoadingViewModel) {
        viewModel.isLoading ? disableView() : enableView()
    }
}

extension LoginViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
