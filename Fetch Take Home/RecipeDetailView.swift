//
//  RecipeDetailView.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.openURL) private var openURL
    
    let selectedRecipe: Recipe?
    
    var body: some View {
        if let uwSelectedRecipe = selectedRecipe {
            ScrollView {
                
                VStack(spacing: 16) {
                    
                    Text(uwSelectedRecipe.name)
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .minimumScaleFactor(0.001)
                        .padding(.horizontal)
                    
                    if let largeImageUrl = uwSelectedRecipe.photo_url_large {
                        CachedImage(url: largeImageUrl, fill: true)
                            .frame(height: 200)
                            .clipped()
                            .overlay {
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 0.2))
                            }
                    } else if let smallImageUrl = uwSelectedRecipe.photo_url_small {
                        CachedImage(url: smallImageUrl, fill: true)
                            .frame(height: 200)
                            .clipped()
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("Cuisine Type:")
                            .foregroundStyle(.secondary)
                        Spacer(minLength: 16)
                        Text(uwSelectedRecipe.cuisine)
                    }
                    .padding(.horizontal)
                    
                    if let sourceUrlString = uwSelectedRecipe.source_url {
                        
                        if let sourceUrl = URL(string: sourceUrlString) {
                            Divider()
                            
                            Button {
                                openURL(sourceUrl)
                            } label: {
                                HStack(alignment: .center, spacing: 0) {
                                    Text("Source:")
                                        .foregroundStyle(.secondary)
                                    Spacer(minLength: 16)
                                    Text(sourceUrlString)
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(2)
                                        .foregroundStyle(.blue)
                                }
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                        }
                        
                    }
                    
                    if let youtubeUrlString = uwSelectedRecipe.youtube_url {
                        if let youtubeUrl = URL(string: youtubeUrlString) {
                            
                            Divider()
                            
                            Button {
                                openURL(youtubeUrl)
                            } label: {
                                HStack(alignment: .center, spacing: 0) {
                                    Text("YouTube:")
                                        .foregroundStyle(.secondary)
                                    Spacer(minLength: 16)
                                    Text(youtubeUrlString)
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(2)
                                        .foregroundStyle(.blue)
                                }
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                            
                        }
                    }
                    
                    
                }
            }
        } else {
            Text("An Error Has Occured")
        }
    }
}

#Preview {
    ViewController()
}
