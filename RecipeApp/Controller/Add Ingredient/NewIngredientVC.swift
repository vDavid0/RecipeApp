//
//  AddIngredientViewController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 30..
//

import UIKit

class NewIngredientVC: UIViewController {
    private var newIngredientView = NewIngredientView()
    
    var searchableIngredients = [Ingredients]() // list of the not added ingredients
    private var searchResultIngredients = [Ingredients]() //list of ingredients that match the search condition
    
    var passIngredient: ((Ingredients) -> ())? //callback for passing an ingredient
    
    override func loadView() {
        view = UIView()
        title = "Add new ingredient"
        navigationItem.title = "Add ingredient"
        view.backgroundColor = UIColor.systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelView))
        sheetPresentationController?.prefersGrabberVisible = true

        view.addSubview(newIngredientView)
        newIngredientView.pinWithMargin(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        setDelegates()
        updateSearchResult()
    }
    
    private func addTargets() {
        newIngredientView.searchTextField.addTarget(self, action: #selector(updateSearchResult), for: .editingChanged)
    }
    
    private func setDelegates() {
        newIngredientView.searchTextField.delegate = self // used to hide keyboard
        newIngredientView.searchResultTableView.dataSource = self
        newIngredientView.searchResultTableView.delegate = self
    }
    
//  when searchTextField's text changes, calculate filtered ingredients
    @objc private func updateSearchResult() {
        let trimmedText = newIngredientView.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        searchResultIngredients = searchableIngredients.filter { $0.rawValue.hasPrefix(trimmedText) }
        newIngredientView.searchResultTableView.reloadData()
    }
    
    @objc private func cancelView() {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newIngredientView.searchTextField.becomeFirstResponder()
    }
}

extension NewIngredientVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResultIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel?.text = searchResultIngredients[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: "plus")
        cell.imageView?.tintColor = .label
        cell.textLabel?.textColor = .secondaryLabel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      when user selects a cell, return with that ingredient, dismiss current screen
        guard let ingredientName = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
        let selectedIngredient = searchableIngredients.first { $0.rawValue == ingredientName }
        
        if selectedIngredient != nil {
            passIngredient?(selectedIngredient!)
        }
        
        dismiss(animated: true)
    }
}

extension NewIngredientVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
