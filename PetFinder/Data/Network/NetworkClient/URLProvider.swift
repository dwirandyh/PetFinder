//
//  URLProvider.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import Foundation

protocol URLProvider {
    var url: URL? { get }
    var headers: [String: String] { get }
}
