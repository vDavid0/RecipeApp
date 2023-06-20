//
//  ProfileViewController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 18..
//

import UIKit
import AVFoundation

// A profile page view. Displays the selected user's name, and videos as imageViews.
class ProfileVC: UIViewController {
    private var profileView = ProfileView()
    private var recipes = [Recipe]()
    private var images = [UIImage]() //first frame of every video as uiimage
    
    override func loadView() {
        view = UIView()
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = UIColor.systemBackground
        
        view.addSubview(profileView)
        profileView.pinFullSafe(to: view)
        profileView.videosCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setDelegates()
    }
    
    private func fetchData() {
        recipes = RecipeService.shared.fetchRecipes() //get users recipes
        createImages()
    }
    
    private func setDelegates() {
        profileView.videosCollectionView.dataSource = self
        profileView.videosCollectionView.delegate = self
    }
    
    @objc private func showMenu() {
        let menuVC = MenuVC()
        navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func createImages() {
        for recipe in recipes {
            let img = VideoConverter.shared.convertVideoToImage(with: recipe.video?.url)
            images.append(img)
        }
    }
}

extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.id, for: indexPath) as? VideoCell else {
            fatalError("Unable to dequeue VideoCell.")
        }
        cell.setImageView(with: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileVideoVC = ProfileRecipeStackVC()
        profileVideoVC.recipeManager.checkIfNewVideo(newIndex: indexPath.row)
        self.navigationController?.pushViewController(profileVideoVC, animated: true)
        profileVideoVC.recipeManager.recipes = recipes
        profileVideoVC.setScrollViewOffsetWith(video: indexPath.row)
    }
}
