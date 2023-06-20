//
//  ScanResultTableViewController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 13..
//
import UIKit

protocol IngredientsDelegate {
    func pass(ingredients: [Ingredients])
    func submitIngredients()
}

class IngredientsVC: UIViewController {
    private var ingredientsView = IngredientsView()

    var ingredients = [Ingredients]() // added ingredients
    var delegate: IngredientsDelegate?
    
    override func loadView() {
        view = ingredientsView
        ingredientsView.ingredientsCollectionView.register(IngredientCell.self, forCellWithReuseIdentifier: IngredientCell.id)
        
        view.backgroundColor = UIColor.systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.detents =  [.large(), .medium()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        setDelegates()
    }
    
    private func addTargets() {
        ingredientsView.newIngredientButton.addTarget(self, action: #selector(showNewIngredientVC), for: .touchUpInside)
        ingredientsView.submitComponent.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
    }
    
    private func setDelegates() {
        ingredientsView.ingredientsCollectionView.dataSource = self
        ingredientsView.ingredientsCollectionView.delegate = self
    }
    
    @objc private func showNewIngredientVC() {
        let searchableIngredients = Ingredients.allCases.filter { !ingredients.contains($0) } // not added ingredients list

        let newIngredientVC = NewIngredientVC()
        newIngredientVC.searchableIngredients = searchableIngredients
        newIngredientVC.passIngredient = { [weak self] ingredient in
            self?.add(ingredient: ingredient)
        }
        
        let navController = UINavigationController(rootViewController: newIngredientVC)
        present(navController, animated: true)
    }
    
    @objc private func submitButtonPressed() {
        dismiss(animated: true)
        delegate?.submitIngredients()
    }
    
    private func add(ingredient: Ingredients) {
        if !ingredients.contains(ingredient) {
            ingredients.append(ingredient)
            ingredientsView.ingredientsCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.pass(ingredients: ingredients)
    }
}

//  list of added ingredients
extension IngredientsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCell.id, for: indexPath) as! IngredientCell
        let cellIngredient = ingredients[indexPath.item]
        
        cell.imageView.image = UIImage(named: cellIngredient.rawValue)
        cell.nameLabel.text = cellIngredient.rawValue
        return cell
    }
    
    // MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ( view.bounds.width / 3 ) - 15
        let height = width * 1.28
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDeleteAlert(with: ingredients[indexPath.item], index: indexPath.item)
    }
    
    private func showDeleteAlert(with ingredient: Ingredients, index: Int) {
        let ac = UIAlertController(title: "Delete ingredient", message: ingredient.rawValue , preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.ingredients.remove(at: index)
            self?.ingredientsView.ingredientsCollectionView.reloadData()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}
