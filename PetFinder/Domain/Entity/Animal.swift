//
//  Animal.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import Foundation

struct Animal: Equatable {
    let name: String
    let kingdom: String?
    let phylum: String?
    let taxonomyClass: String?
    let order: String?
    let family: String?
    let genus: String?
    let scientificName: String?
    let location: [String]
}
