//
//  AnimalListViewModelTests.swift
//  PetFinderTests
//
//  Created by Dwi Randy H on 18/01/24.
//

@testable import PetFinder
import XCTest

@MainActor
final class AnimalListViewModelTests: XCTestCase {
    
    private var sut: AnimalListViewModel!
    private var useCase: MockAnimalUseCase!

    override func setUpWithError() throws {
        useCase = .init()
        sut = .init(useCase: useCase)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func test_onLoadWithoutIssue_shouldLoadAnimalsBasedCategory_Successfully() async throws {
        useCase.getAnimalCategoryHandler = {
            return AnimalCategory.fakeAnimalCategories
        }
        useCase.findAnimalHandler = { name in
            return Animal.fakeAnimals
        }
        
        await sut.onLoad()
        
        XCTAssertEqual(sut.animalCategory, AnimalCategory.fakeAnimalCategories)
        XCTAssertEqual(sut.animalsResult, .success(Animal.fakeAnimals))
    }
    
    func test_onLoadWithoutConnection_shouldShowErrorMessage() async throws {
        useCase.getAnimalCategoryHandler = {
            throw NetworkError.unknown
        }
        
        await sut.onLoad()
        
        XCTAssertEqual(sut.animalsResult, .error)
    }
    
    func test_categoryDidChange_shouldLoadAnimalsByCategorySuccesfully() async throws {
        useCase.findAnimalHandler = { name in
            if name == AnimalCategory.fakeAnimalCategories.first?.name {
                return Animal.fakeAnimals
            } else {
                return []
            }
        }
        
        await sut.animalCategoryDidChange(category: AnimalCategory.fakeAnimalCategories.first!)
        
        XCTAssertEqual(sut.animalsResult, .success(Animal.fakeAnimals))
    }
    
    func test_categoryDidChangeWithConnectionIssue_shoudShowErrorView() async throws {
        useCase.findAnimalHandler = { _ in
            throw NetworkError.unknown
        }
        
        await sut.animalCategoryDidChange(category: AnimalCategory.fakeAnimalCategories.first!)
        
        XCTAssertEqual(sut.animalsResult, .error)
    }
}
