//
//  ContentView.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import SwiftUI
import SwiftData

struct ViewController: View {

    @StateObject fileprivate var viewModel = ViewControllerViewModel()
    
    var body: some View {
        if let recipeContainer = viewModel.recipeContainer,
            recipeContainer.processed {
            NavigationStack(path: viewModel.getPathBinding()) {
                RecipeView(
                    path: viewModel.getPathBinding(),
                    cuisines: recipeContainer.cuisines,
                    recipeDict: recipeContainer.recipeDict,
                    refreshRecipes: refreshRecipes
                )
            }
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
    
    @Published var recipeContainer: RecipeContainer?
    @Published var path: [String]
    
    init() {
        self.path = []
    }
    
    func getPathBinding() -> Binding<[String]> {
        return Binding(get: {
            self.path
        }, set: { newPath in
            self.path = newPath
        })
    }
    
    func fetchRecepies() async {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
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
                } catch {
                    print("fetchRecepies Decoding error")
                    print(error)
                }
                Task {
                    tempRecipeContainer!.processRecipes()
                    self.recipeContainer = tempRecipeContainer
                }
                
                
            }
            
            
            
            
        }.resume()
    }
}

#Preview {
    ViewController()
}
