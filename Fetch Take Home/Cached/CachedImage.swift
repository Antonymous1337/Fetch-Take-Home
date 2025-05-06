//
//  CachedImage.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import SwiftUI

struct CachedImage: View {
    
    @StateObject private var manager = CachedImageManager()
    let url: String
    
    var body: some View {
        ZStack {
            if let data = manager.data,
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        .task {
            await manager.load(url)
        }
    }
}

#Preview {
    ViewController()
}
