//
//  LoginView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 07..
//

import UIKit

class LoginView: UIControl {
    private var welcomeLabel: UITextField = {
        let label = UITextField()
        label.isUserInteractionEnabled = false
        label.text = "Welcome!"
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var userImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "User"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var emailTextField = EmailTextField()
    private var passwordTextField = PasswordTextField()
    
    var loginButton: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        addSubview(welcomeLabel)
        addSubview(userImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(signUpLabel)
        addSubview(signUpButton)

        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            userImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            userImageView.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            
            emailTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor ,constant: -20),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            
            signUpLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            signUpLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            signUpButton.centerYAnchor.constraint(equalTo: signUpLabel.centerYAnchor),
        ])
    }
}
