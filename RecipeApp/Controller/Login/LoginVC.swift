//
//  LoginViewController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 11..
//

import UIKit

class LoginVC: UIViewController {
    private let loginView = LoginView()
    
    override func loadView() {
        addTargets()
        loginView.layoutIfNeeded() //force the view to lay out its subviews immediately

        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func addTargets() {
        loginView.addTarget(self, action: #selector(backgroundTapped), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }
    
    //   remove focus from all views
    @objc private func backgroundTapped() {
        view.endEditing(true)
    }
    
    @objc private func signUpButtonPressed() {
        let signUpVC = SignUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    //    set new rootViewController
    @objc private func loginButtonPressed() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let window = windowScene.windows.first else { return }
        window.rootViewController = MyTabBarController()
    }
}

