//
//  MainVideoViewController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 10..
//

import UIKit

class MainRecipeStackVC: UIViewController, UIGestureRecognizerDelegate {
    private var recipeScrollView = RecipesScrollView()
    
    let recipeManager = RecipeManager()
    
    override func loadView() {
        view = UIView()
        view.addSubview(recipeScrollView)
        recipeScrollView.delegate = self
        recipeScrollView.pinBottomSafe(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeManager.fetchData()
        addVideoPlayers()
    }
    
//  add videoPlayers to the stackview
    private func addVideoPlayers() {
        for recipe in recipeManager.recipes {
            let videoVC = createVideoPlayer(with: recipe)
            add(child: videoVC)
        }
    }
    
    private func createVideoPlayer(with recipe: Recipe) -> RecipeVC{
        let videoVC = RecipeVC()
        videoVC.recipe = recipe
        videoVC.userButtonTapped = { [weak self] in
            let profileVC = ProfileVC()
            self?.navigationController?.pushViewController(profileVC, animated: true)
        }
        return videoVC
    }
    
//  add videoVC to the stackview
    private func add(child: RecipeVC) {
        addChild(child)
        recipeScrollView.stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
        
    private func getVideoHeight() -> CGFloat {
        return UIScreen.main.bounds.height - (navigationController?.tabBarController?.tabBar.frame.size.height ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

//      start currently visible video
        recipeManager.startPlayingCurrentVideo()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//      stop playing currently visible video
        recipeManager.stopPlayingCurrentVideo()
    }
}

extension MainRecipeStackVC: UIScrollViewDelegate {
    //  when scrolling ends
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // check if it is a new video
        let currentlyDisplayedVideoIndex = Int(scrollView.contentOffset.y / getVideoHeight())
        recipeManager.checkIfNewVideo(newIndex: currentlyDisplayedVideoIndex)
        
    }
}
