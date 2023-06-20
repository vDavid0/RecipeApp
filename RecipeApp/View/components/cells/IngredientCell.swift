//
//  AddedIngredientsCell.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 13..
//

import UIKit

// Cellview of an added ingredient. image plus ingredient name
class IngredientCell: UICollectionViewCell {
    static let id = String(describing: IngredientCell.self)
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marker Felt", size: 16)
        label.contentMode = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    private func setView() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        styling()
        setLayout()
    }
    
    private func styling() {
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 4.0
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.masksToBounds = true
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 2 * contentView.bounds.height / 3),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
