//
//  Recepies.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import Foundation

struct Recipe: Codable {
    let cuisine: String
    let name: String
    let photo_url_large: Optional<String>
    let photo_url_small: Optional<String>
    let source_url: Optional<String>
    let uuid: String
    let youtube_url: Optional<String>
    
    private enum CodingKeys: CodingKey {
        case cuisine
        case name
        case photo_url_large
        case photo_url_small
        case source_url
        case uuid
        case youtube_url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cuisine = try container.decode(String.self, forKey: .cuisine)
        name = try container.decode(String.self, forKey: .name)
        photo_url_large = try container.decodeIfPresent(String.self, forKey: .photo_url_large)
        photo_url_small = try container.decodeIfPresent(String.self, forKey: .photo_url_small)
        source_url = try container.decodeIfPresent(String.self, forKey: .source_url)
        uuid = try container.decode(String.self, forKey: .uuid)
        youtube_url = try container.decodeIfPresent(String.self, forKey: .youtube_url)
    }
}
