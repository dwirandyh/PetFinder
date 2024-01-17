//
//  NetworkError.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case notFound
    case badRequest
    case unknown
}
