//
//  DescriptionView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 06..
//

import UIKit

// Contains the name of the recipe, and the description step by step as a tableview. User can navigate to this view from a recipes video, with the description button.
class DescriptionView: UIView {
    var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marker Felt", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stepsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.systemBackground
        
        self.addSubview(recipeNameLabel)
        self.addSubview(stepsTableView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            recipeNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            stepsTableView.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor),
            stepsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stepsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stepsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setNameLabel(to title: String?) {
        recipeNameLabel.text = title
    }
}

