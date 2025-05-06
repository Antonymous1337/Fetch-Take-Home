//
//  ContentView.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import SwiftUI
import SwiftData

struct ViewController: View {

    // You can change which API Endpoint to use by changing APIEndpointType to either .allRecipes, .malformed, or .empty
    @StateObject fileprivate var viewModel = ViewControllerViewModel(APIEndpointType: .malformed)
    
    var body: some View {
        if let recipeContainer = viewModel.recipeContainer,
            recipeContainer.processed {
            
            if recipeContainer.recipes.isEmpty {
                
                EmptyRecipesView(refreshRecipes: refreshRecipes)
                
            } else {
                NavigationStack(path: viewModel.getPathBinding()) {
                    RecipeView(
                        path: viewModel.getPathBinding(),
                        selectedRecipe: viewModel.getSelectedRecipeBinding(),
                        recipes: recipeContainer.recipes,
                        cuisines: recipeContainer.cuisines,
                        recipeDict: recipeContainer.recipeDict,
                        refreshRecipes: refreshRecipes
                    )
                    .navigationDestination(for: String.self) { destination in
                        switch destination {
                        case .recipeDetailView:
                            RecipeDetailView(selectedRecipe: viewModel.selectedRecipe)
                        default:
                            Rectangle()
                                .onAppear {
                                    _ = viewModel.path.popLast()
                                }
                        }
                    }
                }
            }
        } else if viewModel.errorOccured {
            
            MalformedDataView(refreshRecipes: refreshRecipes)
            
        } else {
            ProgressView()
                .onAppear {
                    refreshRecipes()
                }
        }
    }
    
    private func refreshRecipes() {
        Task {
            await viewModel.fetchRecepies()
        }
    }

}

@MainActor
fileprivate class ViewControllerViewModel: ObservableObject {
    
    let APIEndpointType: APIEndpointTypes
    @Published var recipeContainer: RecipeContainer?
    @Published var path: [String]
    @Published var selectedRecipe: Recipe?
    
    @Published var errorOccured: Bool
    
    init(APIEndpointType: APIEndpointTypes) {
        self.APIEndpointType = APIEndpointType
        self.path = []
        errorOccured = false
    }
    
    func getPathBinding() -> Binding<[String]> {
        return Binding(get: {
            self.path
        }, set: { newPath in
            self.path = newPath
        })
    }
    
    func getSelectedRecipeBinding() -> Binding<Recipe?> {
        return Binding(get: {
            self.selectedRecipe
        }, set: { newSelectedRecipe in
            self.selectedRecipe = newSelectedRecipe
        })
    }
    
    func fetchRecepies() async {
        
        var urlString = ""
        
        // All Recipes
        switch APIEndpointType {
        case .allRecipes:
            urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        case .malformed:
            urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        case .empty:
            urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        }
    
        guard let url = URL(string: urlString) else {
            return
        }
        
        let _: Void = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("fetchRecepies Data is nil")
                return
            }
            guard error == nil else {
                print("fetchRecepies Error Occured")
                return
            }
            
            DispatchQueue.main.async {
                var tempRecipeContainer: RecipeContainer?
                do {
                    tempRecipeContainer = try JSONDecoder().decode(RecipeContainer.self, from: data)
                    
                    Task {
                        tempRecipeContainer!.processRecipes()
                        self.recipeContainer = tempRecipeContainer
                    }
                } catch {
                    print("fetchRecepies Decoding error")
                    print(error)
                    self.errorOccured = true
                }
                
                
            }
            
            
            
            
        }.resume()
    }
}

#Preview {
    ViewController()
}
