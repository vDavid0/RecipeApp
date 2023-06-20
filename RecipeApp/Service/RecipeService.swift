//
//  VideoManage.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 11..
//

import Foundation
import AVKit
import AVFoundation

final class RecipeService {
    static let shared = RecipeService()
    
    func fetchRecipes() -> [Recipe] {
        var recipes = [Recipe]()
        for _ in 0..<10 {
            let recipe = getRecipe()
            recipes.append(recipe)
        }
        
        return recipes
    }
    
    private func getRecipe() -> Recipe{
        let videoNumber = Int.random(in: 0...1);
        let url = Bundle.main.url(forResource: "video\(videoNumber)", withExtension: "mp4")!
        let video = Video(player: AVQueuePlayer(url: url), url: url)
        let recipe = Recipe(name: "Spagetti Bolognese",
                            description:  [
                                "A typical method of preparation is to heat butter and olive oil together, add diced carrot, celery",
                                "and onion, and the vegetables are softened. To this soffrittois added the meat. When the meat is lightly browned",
                                "tomato paste, puréed tomatoes, and water or chicken or beef broth are added",
                                "and the whole is left to simmer over very low heat for an hour or two until reduced to a thick sauce."
                            ],
                            ingredients: [Ingredients.Bean, Ingredients.Cheese, Ingredients.Egg, Ingredients.Garlic],
                            video: video,
                            user: User()
        )
        return recipe
    }
}
