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
        guard let encodedStringURL = "\(baseURL)/\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else { return nil }
        let url = URL(string: encodedStringURL)
        return url
    }
}

extension PexelsURLProvider {
    static func searchPhoto(keyword: String, page: Int) -> PexelsURLProvider {
        return PexelsURLProvider(
            path: "v1/search?query=\(keyword)&page=\(page)"
        )
    }
}
