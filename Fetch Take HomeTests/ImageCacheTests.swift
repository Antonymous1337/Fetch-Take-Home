//
//  ImageCacheTests.swift
//  Fetch Take HomeTests
//
//  Created by Antony Holshouser on 5/6/25.
//

import XCTest
@testable import Fetch_Take_Home

final class ImageCacheTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCachedImageManager() async throws {
        
        ImageCache.shared._resetCache()
        let manager = CachedImageManager()
        
        let cachedString1 = await manager.load("https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        XCTAssert(cachedString1 == .setCache, "New Image 1 Set to Cache")
        
        let cachedString2 = await manager.load("https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")
        XCTAssert(cachedString2 == .setCache, "New Image 2 Set to Cache")
        
        let cachedString3 = await manager.load("https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        XCTAssert(cachedString3 == .fetchedCache, "Old Image 1 Fetched From Cache")
        
        let cachedString4 = await manager.load("https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")
        XCTAssert(cachedString4 == .fetchedCache, "Old Image 2 Fetched From Cache")
        
    }

}
