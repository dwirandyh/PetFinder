//
//  AnimalPhoto.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import Foundation

struct AnimalPhoto: Identifiable {
    let id: Int
    let photographer: String
    let photographerURL: URL?
    let photo: PhotoSource
}

extension AnimalPhoto {
    struct PhotoSource {
        let original: String
        let large: String
        let medium: String
        let small: String
        let portrait: String
        let landspace: String
        let tiny: String
    }
}
