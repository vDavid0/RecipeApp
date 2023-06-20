//
//  ConfirmButton.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 07..
//

import UIKit

// Used at login and signup view for logging in/signing up
class ConfirmButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        self.configuration = configuration
        titleLabel?.font = UIFont.systemFont(ofSize: 24)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
