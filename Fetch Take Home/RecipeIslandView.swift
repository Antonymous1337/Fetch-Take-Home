//
//  RecipeIslandView.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/6/25.
//

import SwiftUI

struct RecipeIslandView: View {
    let recipe: Recipe
    @Binding var path: [String]
    @Binding var selectedRecipe: Recipe?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .opacity(0)
            .frame(width: 150, height: 160)
            .background {
                if let recipeString = recipe.photo_url_small {
                    CachedImage(url: recipeString, fill: true)
                } else if let recipeString = recipe.photo_url_large {
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
                        .fill(.black)
                        .opacity(0.9)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .mask {
                RoundedRectangle(cornerRadius: 16)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1))
            }
            .onTapGesture {
                selectedRecipe = recipe
                path.append(.recipeDetailView)
            }
    }
}

#Preview {
    ViewController()
}
