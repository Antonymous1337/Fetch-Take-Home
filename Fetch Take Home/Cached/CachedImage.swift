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
    let fill: Bool
    
    var body: some View {
        ZStack {
            if let data = manager.data,
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: fill ? .fill : .fit)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
