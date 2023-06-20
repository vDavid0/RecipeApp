//
//  ProfileView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 06..
//

import UIKit

// Contains a user's name label and a collectionview of the user's videos
class ProfileView: UIView {
    private var profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Profile"
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var videosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width / 3) - 10
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(profileNameLabel)
        addSubview(videosCollectionView)

        setupLayout()
    }
        
    private func setupLayout() {
        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            profileNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            videosCollectionView.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 60),
            videosCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videosCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videosCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setProfileNameLabelTitle(to text: String) {
        profileNameLabel.text = text
    }
}
