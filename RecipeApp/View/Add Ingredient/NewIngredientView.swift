//
//  AddIngredientView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 06..
//

import UIKit

// Used for adding ingredients. It contains a search textfield and a tableview of ingredients that matches the condition given by the user.
class NewIngredientView: UIView {
    var searchTextField: UITextField = {
        let textField = UITextField()
        let leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        leftView.frame = CGRect(x: 0, y: 0, width: leftView.image!.size.width, height: leftView.image!.size.height)
        leftView.contentMode = .scaleAspectFit
        // Create a UIView with left padding and add the image view as a subview
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftView.frame.size.width + 15, height: leftView.frame.size.height + 15))
        leftView.center = CGPoint(x: paddingView.frame.size.width / 2, y: paddingView.frame.size.height / 2)
        paddingView.addSubview(leftView)
        
        textField.placeholder = "Ingredient name"
        textField.clearButtonMode = .whileEditing
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.leftView?.tintColor = .secondarySystemBackground
        textField.layer.cornerRadius = 10
        textField.layer.backgroundColor = UIColor.systemGray3.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var separatorLine: UIView = {
        let separator = UIView()
        separator.backgroundColor = .gray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    var searchResultTableView: UITableView = {
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
        addSubview(searchTextField)
        addSubview(separatorLine)
        addSubview(searchResultTableView)
        
        setupLayout()
    }
        
    private func setupLayout() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            separatorLine.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            separatorLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            searchResultTableView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor),
            searchResultTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchResultTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchResultTableView.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor)
        ])
    }
}
