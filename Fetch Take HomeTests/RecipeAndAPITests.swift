//
//  Fetch_Take_HomeTests.swift
//  Fetch Take HomeTests
//
//  Created by Antony Holshouser on 5/5/25.
//

import XCTest
@testable import Fetch_Take_Home

final class RecipeAndAPITests: XCTestCase {
    
    @MainActor
    func testEmptyRecipes() async throws {
        let emptyViewController = ViewControllerViewModel(APIEndpointType: .empty)
        await emptyViewController.fetchRecepies()
        try? await Task.sleep(for: .seconds(0.1))
        
        XCTAssertNotNil(emptyViewController.recipeContainer, "Recipe Container Exists")
        guard let uwRecipeContainer = emptyViewController.recipeContainer else {
            return
        }
        
        XCTAssertTrue(uwRecipeContainer.recipes.isEmpty, "Recipe Container is Empty")
        XCTAssertTrue(uwRecipeContainer.processed, "Recipe Container is Processed")
    }
    
    @MainActor
    func testMalformedRecipes() async throws {
        let malformedViewController = ViewControllerViewModel(APIEndpointType: .malformed)
        await malformedViewController.fetchRecepies()
        try? await Task.sleep(for: .seconds(0.1))
        
        XCTAssertNil(malformedViewController.recipeContainer, "Recipe Container Doesn't Exist")
    }
    
    @MainActor
    func testAllRecipes() async throws {
        let allRecipesViewController = ViewControllerViewModel(APIEndpointType: .allRecipes)
        await allRecipesViewController.fetchRecepies()
        try? await Task.sleep(for: .seconds(0.1))
        
        XCTAssert(allRecipesViewController.recipeContainer != nil, "Recipe Container Exists")
        guard let uwRecipeContainer = allRecipesViewController.recipeContainer else {
            return
        }
        
        XCTAssertFalse(uwRecipeContainer.recipes.isEmpty, "Recipe Container Isn't Empty")
        XCTAssertTrue(uwRecipeContainer.processed, "Recipe Container is Processed")
    }
    
    @MainActor
    func testProcessedRecipes() async throws {
        let customRecipesViewController = ViewControllerViewModel(APIEndpointType: .empty)
        let setupTestRecipes = [
            Recipe(tcuisine: "A", tname: "A", tuuid: "1"),
            Recipe(tcuisine: "A", tname: "B", tuuid: "1"),
            Recipe(tcuisine: "A", tname: "C", tuuid: "1"),
            Recipe(tcuisine: "A", tname: "D", tuuid: "1"),
            Recipe(tcuisine: "B", tname: "A", tuuid: "1"),
            Recipe(tcuisine: "B", tname: "B", tuuid: "1"),
            Recipe(tcuisine: "B", tname: "C", tuuid: "1"),
            Recipe(tcuisine: "C", tname: "A", tuuid: "1"),
            Recipe(tcuisine: "C", tname: "B", tuuid: "1"),
            Recipe(tcuisine: "C", tname: "C", tuuid: "1"),
            Recipe(tcuisine: "C", tname: "D", tuuid: "1"),
            Recipe(tcuisine: "C", tname: "E", tuuid: "1"),
            Recipe(tcuisine: "C", tname: "F", tuuid: "1"),
        ]
        var shuffledTestRecipes = setupTestRecipes
        shuffledTestRecipes.shuffle()
        
        XCTAssert(setupTestRecipes != shuffledTestRecipes, "Setup Test and Shuffled Recipes are Different")
        
        customRecipesViewController.recipeContainer = RecipeContainer(testRecipes: shuffledTestRecipes)
        customRecipesViewController.recipeContainer!.processRecipes()
        try? await Task.sleep(for: .seconds(0.1))
        
        XCTAssert(customRecipesViewController.recipeContainer != nil, "Recipe Container Exists")
        guard let uwRecipeContainer = customRecipesViewController.recipeContainer else {
            return
        }
        
        XCTAssertFalse(uwRecipeContainer.recipes.isEmpty, "Recipe Container Isn't Empty")
        XCTAssertTrue(uwRecipeContainer.processed, "Recipe Container is Processed")
        
        XCTAssert(setupTestRecipes == uwRecipeContainer.recipes, "Recipe Container Sorted Recipes")
        
        XCTAssert(uwRecipeContainer.cuisines == ["A", "B", "C"], "Recipe Container has Sorted Cuisines")
        
        
        let recipeDict = uwRecipeContainer.recipeDict
        XCTAssert(recipeDict.count == 3, "RecipeDict has Correct Count")
        
        XCTAssertNotNil(recipeDict["A"], "RecipeDict has A")
        XCTAssertNotNil(recipeDict["B"], "RecipeDict has B")
        XCTAssertNotNil(recipeDict["C"], "RecipeDict has C")
        XCTAssertNil(recipeDict["D"], "RecipeDict does NOT have D")
        
        guard recipeDict["A"] != nil && recipeDict["B"] != nil && recipeDict["C"] != nil else {
            return
        }
        
        XCTAssert(recipeDict["A"]! == Array(setupTestRecipes.prefix(4)), "RecipeDict A is Sorted")
        XCTAssert(recipeDict["B"]! == Array(setupTestRecipes.prefix(7).suffix(3)), "RecipeDict B is Sorted")
        XCTAssert(recipeDict["C"]! == Array(setupTestRecipes.suffix(6)), "RecipeDict C is Sorted")
        
        
    }
    
    

}
