//
//  LoginScreen.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 01/12/23.
//

import UIKit

class LoginScreen: UIView {
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
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .done
        textField.text = "pirulito@gmail.com"
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.isSecureTextEntry = true
        textField.text = "123456"
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Entrar", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
     lazy var goToRegisterLabel: UILabel = {
        let label = UILabel()
        label.text = "Nao tem conta?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var goToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cadastre-se", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var registerStackView = makeHorizontalStack(with: [UIView(),
                                                                    goToRegisterLabel,
                                                                    goToRegisterButton],
                                                            spacing: 8)
    
}

extension  LoginScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(registerStackView)
        containerView.addSubview(loginButton)
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
        
        emailTextField.fillConstraints(
            top: containerView.topAnchor,
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
        
        registerStackView.fillConstraints(
            top: passwordTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        loginButton.fillConstraints(
            top: registerStackView.bottomAnchor,
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
