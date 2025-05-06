//
//  Recepies.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import Foundation

struct Recipe: Codable, Equatable {
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
    
    // For Testing Purposes
    init(tcuisine: String, tname: String, tphoto_url_large: Optional<String> = nil, tphoto_url_small: Optional<String> = nil, tsource_url: Optional<String> = nil, tuuid: String, tyoutube_url: Optional<String> = nil) {
        self.cuisine = tcuisine
        self.name = tname
        self.photo_url_large = tphoto_url_large
        self.photo_url_small = tphoto_url_small
        self.source_url = tsource_url
        self.uuid = tuuid
        self.youtube_url = tyoutube_url
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.cuisine == rhs.cuisine &&
        lhs.name == rhs.name &&
        lhs.photo_url_large == rhs.photo_url_large &&
        lhs.photo_url_small == rhs.photo_url_small &&
        lhs.source_url == rhs.source_url &&
        lhs.uuid == rhs.uuid &&
        lhs.youtube_url == rhs.youtube_url
    }
}
