//
//  VideoVC.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 03..
//

import AVKit
import UIKit

class RecipeVC: UIViewController {
    private let annotationsView = AnnotationsView()
    
    var playerVC = AVPlayerViewController()
    var recipe: Recipe? {
        didSet {
            playerVC.player = recipe?.video?.player
            playerVC.showsPlaybackControls = false
            playerVC.videoGravity = .resizeAspectFill
            playerVC.requiresLinearPlayback = true // playback disable
            
            annotationsView.setView(with: recipe)
        }
    }
    
    var isActive = false
    
    @objc var userButtonTapped: (() -> ())? // behave based on the previous vc (push profile view or dismiss)
    
    override func loadView() {
        view = UIView()
        view.heightAnchor.constraint(equalToConstant : getVideoHeight()).isActive = true
        view.addSubview(playerVC.view)
        setPlayerView()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
    }
    
    private func setPlayerView() {
        playerVC.contentOverlayView?.addSubview(annotationsView)
        playerVC.view.pin(to: view) // playerVC view fills the view
        annotationsView.pin(to: playerVC.contentOverlayView!) // annotations fill the playerVC contentOverlayView
    }
    
    private func addTargets() {
        annotationsView.usernameButton.addTarget(self, action: #selector(userTapped), for: .touchUpInside)
        annotationsView.descriptionButton.addTarget(self, action: #selector(showDescription), for: .touchUpInside)
    }
    
    @objc private func userTapped() {
        userButtonTapped?()
    }
    
    @objc private func showDescription() {
        let descriptionVC = DescriptionVC()
        descriptionVC.recipe = recipe
        
        present(descriptionVC, animated: true)
    }
    
    private func getVideoHeight() -> CGFloat {
        return UIScreen.main.bounds.height - (navigationController?.tabBarController?.tabBar.frame.size.height ?? 0)
    }
}
