//
//  AnimalPhotoUseCase.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import Foundation


protocol AnimalPhotoUseCase {
    func findAnimalPhoto(animal: Animal, page: Int) async throws -> [AnimalPhoto]
    func getFavoritePhotoByCategory(category: AnimalCategory) -> [AnimalPhoto]
    func addPhotoToFavorite(category: AnimalCategory, photo: AnimalPhoto) throws
    func removePhotoFromFavorite(photo: AnimalPhoto) throws
}

class AnimalPhotoUseCaseImpl: AnimalPhotoUseCase {
    
    static func create() -> AnimalPhotoUseCaseImpl {
        return AnimalPhotoUseCaseImpl(repository: AnimalPhotoRepositoryImpl.create())
    }
    
    private let repository: AnimalPhotoRepository
    
    init(repository: AnimalPhotoRepository) {
        self.repository = repository
    }
    
    func findAnimalPhoto(animal: Animal, page: Int) async throws -> [AnimalPhoto] {
        return try await repository.findAnimalPhoto(keyword: animal.name, page: page)
    }
    
    func getFavoritePhotoByCategory(category: AnimalCategory) -> [AnimalPhoto] {
        return repository.getPhotoByCategory(category: category)
    }
    
    func addPhotoToFavorite(category: AnimalCategory, photo: AnimalPhoto) throws {
        try repository.addPhotoToFavorite(category: category, photo: photo)
    }
    
    func removePhotoFromFavorite(photo: AnimalPhoto) throws {
        try repository.removePhotoFromFavorite(photo: photo)
    }
}
