//
//  AddRecipeView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 12..
//

import UIKit

//  For uploading new recipe.
class AddRecipeView: UIView{
    var nameTextField: UITextField = { // name of the recipe
        let textField = UITextField()
        textField.placeholder = "Recipe name..."
        textField.font = UIFont(name: "Marker Felt", size: 20)

        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.gray.cgColor
        return textField
    }()
    
    var imageView: UIImageView = { // preview of the video as an image.
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var tableView: UITableView = { // add description and ingredients
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
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
        addSubview(nameTextField)
        addSubview(imageView)
        addSubview(tableView)
        backgroundColor = .systemBackground

        setupLayout()
    }
        
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            imageView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            imageView.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -15),
            
            tableView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 200),
            tableView.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor, constant: -80),
        ])
    }
    
    func setImage(to image: UIImage){
        imageView.image = image
    }
    
    func layoutChanged() {
        if imageView.frame.height < 150 {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.imageView.alpha = 0.0
            } completion: { [weak self] _  in
                self?.imageView.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.imageView.alpha = 1
                self?.imageView.isHidden = false
            }
        }
    }
}
