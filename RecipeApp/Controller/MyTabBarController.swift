//
//  TabBarController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 11..
//

import UIKit

class MyTabBarController: UITabBarController {
    var homeNC: UINavigationController!
    var scanNC: UINavigationController!
    var profileNC: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavControllers()
    }
    
    private func setNavControllers() {
        //   main screen, vertical stack of random videos(recipes)
        let homeVideoVC = MainRecipeStackVC()
        let homeTabImage = UIImage(systemName: "house")
        let homeSelectedTabImage = UIImage(systemName: "house.fill")
        homeVideoVC.tabBarItem = UITabBarItem(title: "Home", image: homeTabImage, selectedImage: homeSelectedTabImage)
        homeNC = UINavigationController(rootViewController: homeVideoVC)
        
        //   ingredient selection(with image classification and manual), then showing video stack of recipes that include the provided ingredients
        let scanVC = ScanVC()
        let scanTabImage = UIImage(systemName: "magnifyingglass")
        scanVC.tabBarItem = UITabBarItem(title: "Scanning", image: scanTabImage, selectedImage: scanTabImage)
        scanNC = UINavigationController(rootViewController: scanVC)
        
        //   profile of the logged in user + menu for adding new recipe
        let profileVC = ProfileVC()
        let profileTabImage = UIImage(systemName: "person")
        let profileSelectedTabImage = UIImage(systemName: "person.fill")
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: profileTabImage, selectedImage: profileSelectedTabImage)
        profileVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(showMenu)) //   button for showing the user settings
        profileNC = UINavigationController(rootViewController: profileVC)
        
        self.setViewControllers([homeNC, scanNC, profileNC], animated: false)
    }
    
    @objc private func showMenu() {
        let menuVC = MenuVC()
        profileNC.pushViewController(menuVC, animated: true)
    }
}

