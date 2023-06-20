//
//  ProfileVideoStackVC.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 06..
//

import UIKit

// A recipe stack, we can navigate here only from a ProfileVC 
class ProfileRecipeStackVC: UIViewController, UIGestureRecognizerDelegate {
    private var recipeScrollView = RecipesScrollView()
    
    var recipeManager = RecipeManager()
    
    private var offsetY: CGFloat = 0.0 //scroll to the selected video
    private var didLayoutSubviews = false //viewDidLayoutSubviews got called
    
    override func loadView() {
        view = UIView()
        view.addSubview(recipeScrollView)
        recipeScrollView.delegate = self
        
        recipeScrollView.pinBottomSafe(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVideoPlayers()
    }
    
    // add videoplayers to stackview
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
            self?.navigationController?.popViewController(animated: true)
        }
        return videoVC
    }
    
//  add videoVC to the stackview
    private func add(child: RecipeVC) {
        addChild(child)
        recipeScrollView.stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
        
    func setScrollViewOffsetWith(video index: Int) {
        offsetY = CGFloat(index) * getVideoHeight()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//      stop currently visible video
        recipeManager.stopPlayingCurrentVideo()
    }
    
//  scrollview letekerése a kiválasztott videóra (csak profileVC-ből való érkezés esetén használatos)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didLayoutSubviews {
            recipeScrollView.contentOffset.y = offsetY
            didLayoutSubviews = true
        }
    }
}

extension ProfileRecipeStackVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //  check if we arrived to a new video
        let currentlyDisplayedVideoIndex = Int(scrollView.contentOffset.y / getVideoHeight())
        recipeManager.checkIfNewVideo(newIndex: currentlyDisplayedVideoIndex)
    }
}

