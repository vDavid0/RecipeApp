//
//  SubmitButton.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 05. 02..
//

import UIKit

// Used in AddDescriptionView and IngredientsView, it is a container view with a submit button 
class SubmitView: UIView {
    var submitButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Submit"
        button.configuration?.buttonSize = .large
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        backgroundColor = UIColor.secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(submitButton)
        
        setLayout()
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
            submitButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
        ])
    }
}
