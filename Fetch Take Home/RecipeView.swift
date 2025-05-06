//
//  MainMenu.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import SwiftUI

struct RecipeView: View {
    
    @Binding var path: [String]
    let cuisines: [String]
    let recipeDict: Dictionary<String, [Recipe]>
    
    var body: some View {
        ScrollView {
            
            Text("Recipes")
                .font(.largeTitle)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.001)
            
            LazyVStack {
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
                                            if let recipeURL = URL(string: recipeString) {
                                                AsyncImage(url: recipeURL) { image in
                                                    image
                                                        .image?.resizable()
                                                        .scaledToFill()
                                                }
                                                    
                                            } else {
                                                Rectangle()
                                            }
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
            
            
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ViewController()
}
