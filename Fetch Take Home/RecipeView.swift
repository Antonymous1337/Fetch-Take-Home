//
//  MainMenu.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import SwiftUI

struct RecipeView: View {
    
    @Binding var path: [String]
    @Binding var selectedRecipe: Recipe?
    let cuisines: [String]
    let recipeDict: Dictionary<String, [Recipe]>
    let refreshRecipes: () -> ()
    @StateObject fileprivate var viewModel = RecipeViewViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if !viewModel.refreshed {
                    ProgressView()
                        .frame(height: 60)
                        .opacity((viewModel.scrollOffset.y - 15.0) / 30.0)
                        .scaleEffect(1.2, anchor: .center)
                        .transition(AnyTransition.scale(scale: 0, anchor: .center))
                } else {
                    Text("Refreshed!")
                        .frame(height: 60)
                        .opacity((viewModel.scrollOffset.y - 25.0) / 30.0)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            ScrollView {
                
                LazyVStack {
                    Text("Recipes")
                        .font(.largeTitle)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.001)
                
                
                    ForEach(cuisines, id: \.self) { cuisine in
                        Text(cuisine)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(recipeDict[cuisine]!, id: \.uuid) { recipe in
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 1))
                                        .frame(width: 150, height: 160)
                                        .background {
                                            if let recipeString = recipe.photo_url_small {
                                                CachedImage(url: recipeString, fill: true)
                                            } else {
                                                Rectangle()
                                            }
                                        }
                                        .overlay {
                                            VStack {
                                                Text(recipe.name)
                                                    .foregroundStyle(.white)
                                                    .lineLimit(2, reservesSpace: true)
                                                    .multilineTextAlignment(.center)
                                            }
                                            .padding(8)
                                            .frame(maxWidth: .infinity)
                                            .background {
                                                Rectangle()
                                                    .opacity(0.9)
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                                        }
                                        .mask {
                                            RoundedRectangle(cornerRadius: 16)
                                        }
                                        .onTapGesture {
                                            selectedRecipe = recipe
                                            path.append(.recipeDetailView)
                                        }
                                    if recipe.photo_url_small != nil {
                                        
                                    }
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
                    
                    if value.y <= 0 {
                        viewModel.refreshed = false
                    }
                
                    
                }
                
            }
            .scrollIndicators(.hidden)
            .coordinateSpace(name: "scroll")
            
            
        }
        .background {
            Color.screenBackground
                .ignoresSafeArea()
        }
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
}

#Preview {
    ViewController()
}
