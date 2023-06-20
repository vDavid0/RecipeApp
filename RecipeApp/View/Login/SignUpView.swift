//
//  SignUpView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 07..
//

import UIKit

class SignUpView: UIControl {
    private var createAccountLabel: UITextField = {
        let label = UITextField()
        label.text = "Create an account"
        label.font = UIFont.systemFont(ofSize: 40)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var userImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "User"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var emailTextField = EmailTextField()
    private var passwordTextField = PasswordTextField()
    private var confirmPasswordTextField = PasswordTextField()
    
    var signUpButton: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("Sign up", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    private func setupView() {
        backgroundColor = .systemGray
        confirmPasswordTextField.placeholder = "Confirm Password"
        
        addSubview(createAccountLabel)
        addSubview(userImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(signUpButton)

        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            createAccountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createAccountLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            userImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 30),
            userImageView.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            
            emailTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            signUpButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
        ])
    }
}
