//
//  AnimaListResponse.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import Foundation

struct AnimalResponse: Codable {
    let name: String
    let taxonomy: Taxonomy?
    let locations: [String]
}

extension AnimalResponse {
    struct Taxonomy: Codable {
        let kingdong: String?
        let phylum: String?
        let taxonomyClass: String?
        let order: String?
        let family: String?
        let genus: String?
        let scientificName: String?
        
        enum CodingKeys: String, CodingKey {
            case kingdong
            case phylum
            case taxonomyClass = "class"
            case order
            case family
            case genus
            case scientificName = "scientific_name"
        }
    }
}

extension AnimalResponse {
    func toEntity() -> Animal {
        return Animal(
            name: name,
            kingdom: taxonomy?.kingdong,
            phylum: taxonomy?.phylum,
            taxonomyClass: taxonomy?.taxonomyClass,
            order: taxonomy?.order,
            family: taxonomy?.family,
            genus: taxonomy?.genus,
            scientificName: taxonomy?.scientificName,
            location: locations
        )
    }
}
