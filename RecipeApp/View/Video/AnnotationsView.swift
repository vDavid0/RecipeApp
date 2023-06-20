//
//  AnnotationsView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 05..
//

import UIKit

// Shows information about the name of the recipe, description, and username (on top of a video player)
class AnnotationsView: UIView {
    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marker Felt", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let descriptionButton: UIButton = { // shows the description of a recipe
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.bubble"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.clipsToBounds = true
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .white
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
        addSubview(recipeNameLabel)
        addSubview(usernameButton)
        addSubview(descriptionButton)

        self.backgroundColor = UIColor.clear
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            usernameButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            usernameButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            recipeNameLabel.bottomAnchor.constraint(equalTo: usernameButton.topAnchor, constant: -10),
            recipeNameLabel.leadingAnchor.constraint(equalTo: usernameButton.leadingAnchor),
            
            descriptionButton.topAnchor.constraint(equalTo: recipeNameLabel.topAnchor),
            descriptionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionButton.widthAnchor.constraint(equalToConstant: 35),
            descriptionButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    func setView(with recipe: Recipe?) {
        recipeNameLabel.text = recipe?.name
        usernameButton.setTitle("@\(recipe?.user?.name ?? "N/A")", for: .normal)
    }
}
