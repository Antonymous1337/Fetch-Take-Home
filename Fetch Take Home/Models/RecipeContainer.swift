//
//  RecipeContainer.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import Foundation

struct RecipeContainer: Codable {
    private(set) var recipes: [Recipe]
    private(set) var cuisines: [String]
    private(set) var recipeDict: Dictionary<String, [Recipe]>
    private(set) var processed: Bool
    
    private enum CodingKeys: CodingKey {
        case recipes
        case cuisines
        case recipeDict
        case processed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recipes = try container.decode([Recipe].self, forKey: .recipes)
        cuisines = []
        recipeDict = Dictionary<String, [Recipe]>()
        processed = false
    }
    
    // Testing Purposes
    init(testRecipes: [Recipe]) {
        recipes = testRecipes
        cuisines = []
        recipeDict = Dictionary<String, [Recipe]>()
        processed = false
    }
    
    // Could be decently faster with a priority queues
    mutating func processRecipes() {
        
        var tempCuisines = [String]()
        var tempRecipeDict = Dictionary<String, [Recipe]>() // Cuisine and recipe
        
        self.recipes = recipes.sorted(by: { firstRecipe, secondRecipe in
            if firstRecipe.cuisine == secondRecipe.cuisine {
                firstRecipe.name < secondRecipe.name
            } else {
                firstRecipe.cuisine < secondRecipe.cuisine
            }
        })
        
        for recipe in recipes {
            if tempRecipeDict[recipe.cuisine] == nil {
                tempCuisines.append(recipe.cuisine)
                tempRecipeDict[recipe.cuisine] = [recipe]
            } else {
                tempRecipeDict[recipe.cuisine]!.append(recipe)
            }
        }
        
        self.cuisines = tempCuisines
        self.recipeDict = tempRecipeDict
        self.processed = true
    }
}
