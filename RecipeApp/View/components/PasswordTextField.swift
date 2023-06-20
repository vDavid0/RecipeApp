//
//  PasswordTextField.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 07..
//

import UIKit

// Used at login and signup
class PasswordTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        placeholder = "Password"
        backgroundColor = .gray
        borderStyle = .roundedRect
        isSecureTextEntry = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
