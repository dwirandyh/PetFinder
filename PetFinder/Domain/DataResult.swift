//
//  DataResult.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import Foundation

enum DataResult<T: Equatable>: Equatable {
    case success(T)
    case error
    case loading
}
