//
//  SignUpViewController.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    var coordinator: Coordinator?
    
    private lazy var customView: SignUpScreen? = {
        return view as? SignUpScreen
    }()
        
    var signUp: ((RegisterUserRequest) -> Void)?
    var goToLogin: (() -> Void)?
    
    override func loadView() {
        super.loadView()
        view = SignUpScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView?.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signUpButtonTapped() {
        if let email = customView?.emailTextField.text,
           let password = customView?.passwordTextField.text,
           let username = customView?.usernameTextField.text,
           let passwordConfirmation = customView?.confirmPasswordTextField.text {
            
            let request = RegisterUserRequest(username: username,
                                              email: email,
                                              password: password,
                                              passwordConfirmation: passwordConfirmation)
            signUp?(request)
        }
    }
}

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.goToLogin?()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
