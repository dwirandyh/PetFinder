//
//  AnimalUseCaseMock.swift
//  PetFinderTests
//
//  Created by Dwi Randy H on 18/01/24.
//

@testable import PetFinder
import Foundation

class MockAnimalUseCase: AnimalUseCase {
    init() { }

    private(set) var getAnimalCategoryCallCount = 0
    var getAnimalCategoryHandler: (() async throws -> ([AnimalCategory]))?

    private(set) var findAnimalCallCount = 0
    var findAnimalHandler: ((_ name: String) async throws -> ([Animal]))?

    func getAnimalCategory() async throws -> [AnimalCategory] {
        getAnimalCategoryCallCount += 1
        if let getAnimalCategoryHandler = getAnimalCategoryHandler {
            return try await getAnimalCategoryHandler()
        }
        return [AnimalCategory]()
    }

    func findAnimal(name: String) async throws -> [Animal] {
        findAnimalCallCount += 1
        if let findAnimalHandler = findAnimalHandler {
            return try await findAnimalHandler(name)
        }
        return [Animal]()
    }
}
