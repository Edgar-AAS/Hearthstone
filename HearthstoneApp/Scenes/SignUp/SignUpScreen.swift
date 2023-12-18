//
//  SignUpScreen.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import UIKit

class SignUpScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .done
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cadastrar", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
}

extension SignUpScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(usernameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(confirmPasswordTextField)
        containerView.addSubview(signUpButton)
    }
    
    func setupConstrains() {
        let safeArea = safeAreaLayoutGuide
        
        scrollView.fillConstraints(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: safeArea.bottomAnchor
        )
        
        containerView.fillConstraints(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        usernameTextField.fillConstraints(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        emailTextField.fillConstraints(
            top: usernameTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        passwordTextField.fillConstraints(
            top: emailTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        confirmPasswordTextField.fillConstraints(
            top: passwordTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        signUpButton.fillConstraints(
            top: confirmPasswordTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 16, left: 16, bottom: 16, right: 16),
            size: .init(width: 0, height: 44)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
