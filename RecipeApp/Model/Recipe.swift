//
//  Recipe.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 14..
//

import Foundation

struct Recipe {
    var name = ""
    var description = [String]()
    var ingredients = [Ingredients]()
    
    var video: Video?
    var user: User?
}
