//
//  PexelURLProvider.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import Foundation

struct PexelsURLProvider: URLProvider {
    let baseURL: String = "https://api.pexels.com"
    let path: String
    let headers: [String: String] = [
        "Authorization": "F0RsC7L6viQO7bzFmZTKs7hwGWhXlwm5TjAozyXUwkTmB8INisxbwjVg"
    ]
    
    var url: URL? {
        return URL(string: "\(baseURL)/\(path)")
    }
}

extension PexelsURLProvider {
    static func searchPhoto(keyword: String, page: Int) -> PexelsURLProvider {
        return PexelsURLProvider(
            path: "v1/search?query=\(keyword)&page=\(page)"
        )
    }
}
