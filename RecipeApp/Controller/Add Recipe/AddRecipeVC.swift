//
//  AddRecipeVC.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 03..
//

import UIKit
import AVKit

protocol DescriptionDelegate {
    func pass(description: [String])
}

class AddRecipeVC: UIViewController {
    private var addRecipeView = AddRecipeView()
    
    private var recipe = Recipe() {
        didSet {
            addRecipeView.setImage(to: VideoConverter.shared.convertVideoToImage(with: recipe.video?.url))
        }
    }
    
    override func loadView() {
        view = addRecipeView
        title = "New recipe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addRecipe))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    private func setDelegates() {
        addRecipeView.nameTextField.delegate = self
        addRecipeView.tableView.dataSource = self
        addRecipeView.tableView.delegate = self
    }
    
    @objc private func addRecipe() {
        dismiss(animated: true)
    }
    
    func setVideo(with url: URL) {
        recipe.video = Video(player: AVQueuePlayer(url: url), url: url)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addRecipeView.layoutChanged()
    }
}

extension AddRecipeVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor.secondarySystemBackground
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.section {
        case 0:
            content.text = "Add description"
            let prefix = recipe.description.first?.prefix(10)
            if prefix != nil {
                content.secondaryText = "\(prefix ?? "")..."
            }
        case 1:
            content.text = "Add ingredients"
            content.secondaryText = "\(recipe.ingredients.count) added"
        default:
            break
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Description"
        } else {
            return "Ingredients"
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let addDescriptionVC = AddDescriptionVC()
            addDescriptionVC.delegate = self
            addDescriptionVC.steps = recipe.description
            present(addDescriptionVC, animated: true)
        case 1:
            let ingredientsVC = IngredientsVC()
            ingredientsVC.delegate = self
            ingredientsVC.ingredients = recipe.ingredients
            present(ingredientsVC, animated: true)
        default:
            break
        }
    }
}

extension AddRecipeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddRecipeVC: DescriptionDelegate, IngredientsDelegate {
    func pass(description: [String]) {
        recipe.description = description
        addRecipeView.tableView.reloadData()
    }
    
    // MARK: - IngredientsDelegate
    func pass(ingredients: [Ingredients]) { //pass (manually added) ingredients from IngredientsVC
        recipe.ingredients = ingredients
        addRecipeView.tableView.reloadData()
    }
    
    func submitIngredients() { }
}
