//
//  SignUpViewController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 11..
//

import UIKit

class SignUpVC: UIViewController {
    let signUpView = SignUpView()
    
    override func loadView() {
        view = signUpView
        signUpView.layoutIfNeeded() //force the view to lay out its subviews immediately
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    private func addTargets() {
        signUpView.addTarget(self, action: #selector(backgroundTapped), for: .touchUpInside)
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }
    
//  make keyboard disappear
    @objc private func backgroundTapped() {
        view.endEditing(true)
    }
    
    @objc private func signUpButtonPressed() {
    }
}
