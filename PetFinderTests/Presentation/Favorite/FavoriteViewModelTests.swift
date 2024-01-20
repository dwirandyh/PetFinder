//
//  FavoriteViewModelTests.swift
//  PetFinderTests
//
//  Created by Dwi Randy H on 20/01/24.
//

@testable import PetFinder
import XCTest

@MainActor
final class FavoriteViewModelTests: XCTestCase {

    private var sut: FavoriteViewModel!
    private var animalPhotoUseCase: MockAnimalPhotoUseCase!
    private var animalUseCase: MockAnimalUseCase!
    
    override func setUpWithError() throws {
        animalPhotoUseCase = .init()
        animalUseCase = .init()
        sut = FavoriteViewModel(animalPhotoUseCase: animalPhotoUseCase, animalUseCase: animalUseCase)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_onLoadSuccess_shouldShowFavoritePhotos() async throws {
        animalUseCase.getAnimalCategoryHandler = {
            return AnimalCategory.fakeAnimalCategories
        }
        animalPhotoUseCase.getFavoritePhotoByCategoryHandler = { _ in
            return AnimalPhoto.fakePhotos
        }
        
        await sut.onLoad()
        
        XCTAssertEqual(sut.animalCategory, AnimalCategory.fakeAnimalCategories)
        XCTAssertEqual(sut.selectedAnimalCategory, AnimalCategory.fakeAnimalCategories.first)
        XCTAssertEqual(sut.animalPhotoResult, .success(AnimalPhoto.fakePhotos))
    }
    
    func test_onLoadFailed_shouldShowError() async throws {
        animalUseCase.getAnimalCategoryHandler = {
            throw NetworkError.unknown
        }
        
        await sut.onLoad()
        
        XCTAssertEqual(sut.animalCategory, [])
        XCTAssertNil(sut.selectedAnimalCategory)
        XCTAssertEqual(sut.animalPhotoResult, .error)
    }
    

    func test_animalCategoryDidChange_shouldShowAnimalByCategory() throws {
        animalPhotoUseCase.getFavoritePhotoByCategoryHandler = { category in
            if category == AnimalCategory.fakeAnimalCategory {
                return AnimalPhoto.fakePhotos
            }
            else {
                throw NSError(domain: "category argument is wrong", code: 1)
            }
        }
        
        sut.animalCategoryDidChange(category: AnimalCategory.fakeAnimalCategory)
        
        XCTAssertEqual(sut.animalPhotoResult, .success(AnimalPhoto.fakePhotos))
    }
    
    func test_animalCategoryDidChangeError_shouldShowErrorMessage() throws {
        animalPhotoUseCase.getFavoritePhotoByCategoryHandler = { category in
            throw NetworkError.unknown
        }
        
        sut.animalCategoryDidChange(category: AnimalCategory.fakeAnimalCategory)
        
        XCTAssertEqual(sut.animalPhotoResult, .error)
    }
    
    func test_removeFavoriteTapped_shouldRemovePhotoFromFavorite() throws {
        
        sut.removeFavoriteTapped(photo: AnimalPhoto.fakePhoto)
        
        XCTAssertEqual(animalPhotoUseCase.removePhotoFromFavoriteCallCount, 1)
    }
}
