//
//  MockAnimalPhotoUseCase.swift
//  PetFinderTests
//
//  Created by Dwi Randy H on 18/01/24.
//

@testable import PetFinder
import Foundation

class MockAnimalPhotoUseCase: AnimalPhotoUseCase {
    init() { }

    private(set) var findAnimalPhotoCallCount = 0
    var findAnimalPhotoHandler: ((_ animal: Animal, _ page: Int) async throws -> ([AnimalPhoto]))?

    private(set) var getFavoritePhotoByCategoryCallCount = 0
    var getFavoritePhotoByCategoryHandler: ((_ category: AnimalCategory) throws -> ([AnimalPhoto]))?

    private(set) var addPhotoToFavoriteCallCount = 0
    var addPhotoToFavoriteHandler: ((_ category: AnimalCategory, _ photo: AnimalPhoto) throws -> Void)?

    private(set) var removePhotoFromFavoriteCallCount = 0
    var removePhotoFromFavoriteHandler: ((_ photo: AnimalPhoto) throws -> Void)?

    func findAnimalPhoto(animal: Animal, page: Int) async throws -> [AnimalPhoto] {
        findAnimalPhotoCallCount += 1
        if let findAnimalPhotoHandler = findAnimalPhotoHandler {
            return try await findAnimalPhotoHandler(animal, page)
        }
        return [AnimalPhoto]()
    }

    func getFavoritePhotoByCategory(category: AnimalCategory) throws -> [AnimalPhoto] {
        getFavoritePhotoByCategoryCallCount += 1
        if let getFavoritePhotoByCategoryHandler = getFavoritePhotoByCategoryHandler {
            return try getFavoritePhotoByCategoryHandler(category)
        }
        return [AnimalPhoto]()
    }

    func addPhotoToFavorite(category: AnimalCategory, photo: AnimalPhoto) throws {
        addPhotoToFavoriteCallCount += 1
        try addPhotoToFavoriteHandler?(category, photo)
    }

    func removePhotoFromFavorite(photo: AnimalPhoto) throws {
        removePhotoFromFavoriteCallCount += 1
        try removePhotoFromFavoriteHandler?(photo)
    }
}
