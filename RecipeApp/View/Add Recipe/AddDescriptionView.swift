//
//  AddDescriptionView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 12..
//

import Foundation
import UIKit

// For adding description to a new recipe.
class AddDescriptionView: UIControl {
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var addCellButton: UIButton = { // adds new description step
        let button = UIButton()
        var config = UIButton.Configuration.gray()
        config.title = "Add new step"
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.cornerStyle = .capsule
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var submitComponent = SubmitView()
    
    var tableViewBottomAncor: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.systemBackground
        
        tableViewBottomAncor = tableView.bottomAnchor.constraint(equalTo: submitComponent.topAnchor)

        
        addSubview(tableView)
        addSubview(addCellButton)
        addSubview(submitComponent)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            addCellButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            addCellButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addCellButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            tableView.topAnchor.constraint(equalTo: addCellButton.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: addCellButton.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: addCellButton.trailingAnchor),
            tableViewBottomAncor,
            
            submitComponent.leadingAnchor.constraint(equalTo: leadingAnchor),
            submitComponent.trailingAnchor.constraint(equalTo: trailingAnchor),
            submitComponent.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setKeyboardShownLayout(with height: CGFloat) {
        tableViewBottomAncor.constant = -height + submitComponent.frame.height
        self.layoutIfNeeded()
    }
    
    func setKeyboardHiddenLayout() {
        tableViewBottomAncor.constant = 0
        self.layoutIfNeeded()
    }
}
