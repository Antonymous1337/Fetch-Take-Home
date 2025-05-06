//
//  MainMenu.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import SwiftUI

struct RecipeView: View {
    @Environment(\.isSearching) private var isSearching
    
    @Binding var path: [String]
    @Binding var selectedRecipe: Recipe?
    let recipes: [Recipe]
    let cuisines: [String]
    let recipeDict: Dictionary<String, [Recipe]>
    let refreshRecipes: () -> ()
    @StateObject fileprivate var viewModel = RecipeViewViewModel()
    
    var body: some View {
    
        ZStack {
            VStack {
                if !viewModel.refreshed {
                    ProgressView()
                        .frame(height: 60, alignment: .center)
                        .opacity((viewModel.scrollOffset.y - 15.0) / 30.0)
                        .scaleEffect(1.2, anchor: .center)
                        .transition(AnyTransition.scale(scale: 0, anchor: .center))
                        .padding(.top, isSearching ? 0 : -96)
                } else {
                    Text("Refreshed!")
                        .frame(height: 60)
                        .opacity((viewModel.scrollOffset.y - 25.0) / 30.0)
                        .padding(.top, isSearching ? 0 : -96)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            ScrollView {
                
                LazyVStack {
                
                    ForEach(cuisines, id: \.self) { cuisine in
                        Text(cuisine)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(recipeDict[cuisine]!, id: \.uuid) { recipe in
                                    RecipeIslandView(
                                        recipe: recipe,
                                        path: $path,
                                        selectedRecipe: $selectedRecipe
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(
                    GeometryReader { geometry in
                        Color.screenBackground
                            .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                    }
                )
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    viewModel.scrollOffset = value
                    
                    if value.y >= 60.0 &&
                        !viewModel.refreshing &&
                        !viewModel.refreshed {
                        Task {
                            viewModel.refreshing = true
                            refreshRecipes()
                            viewModel.refreshing = false
                            withAnimation {
                                viewModel.refreshed = true
                            }
                            print("Refreshed")
                        }
                    }
                    
                    if value.y <= 1 {
                        viewModel.refreshed = false
                    }
                    
                }
                
            }
            .scrollIndicators(.hidden)
            .coordinateSpace(name: "scroll")
            
            if viewModel.searchText != "" {
                ScrollView {
                    LazyVStack {
                        let filteredRecipes = viewModel.getFilteredRecipes(recipes: recipes)
                        ForEach(filteredRecipes, id: \.uuid) { recipe in
                            Button {
                                selectedRecipe = recipe
                                path.append(.recipeDetailView)
                            } label: {
                                HStack {
                                    Group {
                                        if let recipeString = recipe.photo_url_small {
                                            CachedImage(url: recipeString, fill: true)
                                                .frame(width: 50, height: 50)
                                        } else if let recipeString = recipe.photo_url_large {
                                            CachedImage(url: recipeString, fill: true)
                                        } else {
                                            Rectangle()
                                        }
                                    }
                                    .mask {
                                        RoundedRectangle(cornerRadius: 8)
                                    }
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .strokeBorder(.black, lineWidth: 0.5)
                                    }
                                    Spacer(minLength: 0)
                                    Text(recipe.name)
                                }
                            }
                            .buttonStyle(.plain)
                            
                            Divider()
                        }
                    }
                    .padding(.horizontal)
                }
                .background {
                    Color.screenBackground
                        .ignoresSafeArea()
                }
            }
            
        }
        .background {
            Color.screenBackground
                .ignoresSafeArea()
        }
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Recipes")
        .navigationBarTitleDisplayMode(.large)
    }
}

fileprivate struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

fileprivate class RecipeViewViewModel: ObservableObject {
    @Published var scrollOffset: CGPoint = .zero
    @Published var refreshing = false
    @Published var refreshed = false
    
    @Published var searchText = ""
    
    func getFilteredRecipes(recipes: [Recipe]) -> [Recipe] {
        guard searchText != "" else {
            return recipes
        }
        return recipes.filter { recipe in
            recipe.name.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    ViewController()
}
