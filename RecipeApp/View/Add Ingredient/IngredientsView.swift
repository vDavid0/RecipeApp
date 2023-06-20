//
//  AddedIngredientsView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 06..
//

import UIKit

// Contains a collection of the added ingredients so far, an add ingerdient button, and a submit button
class IngredientsView: UIView {
    var ingredientsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.collectionViewLayout = layout
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var newIngredientButton: UIButton = { // Shows new screen to add new ingredient to the list
        let button = UIButton()
        var config = UIButton.Configuration.gray()
        config.title = "Add new ingredient"
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.cornerStyle = .capsule
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var submitComponent = SubmitView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        backgroundColor = UIColor.systemBackground
        
        addSubview(newIngredientButton)
        addSubview(ingredientsCollectionView)
        addSubview(submitComponent)
        setLayout()
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            newIngredientButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            newIngredientButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            newIngredientButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            ingredientsCollectionView.topAnchor.constraint(equalTo: newIngredientButton.bottomAnchor, constant: 20),
            ingredientsCollectionView.bottomAnchor.constraint(equalTo: submitComponent.topAnchor, constant: -15),
            ingredientsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            ingredientsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            submitComponent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            submitComponent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            submitComponent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
