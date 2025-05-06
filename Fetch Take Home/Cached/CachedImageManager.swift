//
//  CachedImageManager.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import Foundation

final class CachedImageManager: ObservableObject {
    @Published private(set) var data: Data?
    
    private let imageRetriever = ImageRetriever()
    
    @MainActor
    func load(_ imgUrl: String, cache: ImageCache = .shared) async -> String {
        
        if let imageData = cache.object(forKey: imgUrl as NSString) {
            self.data = imageData
            // print("Fetch Cache")
            return .fetchedCache
        }
        do {
            self.data = try await imageRetriever.fetch(imgUrl)
            if let dataToCache = data as? NSData {
                cache.set(object: dataToCache, forKey: imgUrl as NSString)
                // print("Set Cache")
            }
        } catch {
            print(error)
        }
        return .setCache
    }
}
