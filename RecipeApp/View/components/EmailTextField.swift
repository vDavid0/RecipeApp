//
//  EmailTextField.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 07..
//

import UIKit

// Used at login and signup
class EmailTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        placeholder = "Email"
        backgroundColor = .gray
        borderStyle = .roundedRect
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
