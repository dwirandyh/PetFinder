//
//  AnimalUseCase.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import Foundation

protocol AnimalUseCase {
    func getAnimalCategory() async throws -> [AnimalCategory]
    func findAnimal(name: String) async throws -> [Animal]
}

class AnimalUseCaseImpl: AnimalUseCase {
    
    static func create() -> AnimalUseCaseImpl {
        return AnimalUseCaseImpl(repository: AnimalRepositoryImpl.create())
    }
    
    private let repository: AnimalRepository
    
    init(repository: AnimalRepository) {
        self.repository = repository
    }
    
    func getAnimalCategory() async throws -> [AnimalCategory] {
        return try await repository.getAnimalCategory()
    }
    
    func findAnimal(name: String) async throws -> [Animal] {
        return try await repository.findAnimal(name: name)
    }
}

