//
//  APINinjasURLProvider.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import Foundation

struct APINinjasURLProvider: URLProvider {
    let baseURL: String = "https://api.api-ninjas.com"
    let path: String
    let headers: [String: String] = [
        "X-Api-Key": "pfFQJxLiPMYqvY5rZXbYdw==VBjYVanTRFZdEhx9"
    ]
    
    var url: URL? {
        return URL(string: "\(baseURL)/\(path)")
    }
}

extension APINinjasURLProvider {
    static func animals(name: String) -> APINinjasURLProvider {
        return APINinjasURLProvider(
            path: "v1/animals?name=\(name)"
        )
    }
}
