//
//  ImageRetriever.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/5/25.
//

import Foundation

struct ImageRetriever {
    func fetch(_ imgUrl: String) async throws -> Data {
        guard let url = URL(string: imgUrl) else {
            throw RetrieverError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

private extension ImageRetriever {
    enum RetrieverError: Error {
        case invalidURL
    }
}
