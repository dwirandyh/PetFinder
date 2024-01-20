//
//  AnimalPhotoViewModelTests.swift
//  PetFinderTests
//
//  Created by Dwi Randy H on 20/01/24.
//

@testable import PetFinder
import XCTest

@MainActor
final class AnimalPhotoViewModelTests: XCTestCase {

    private var sut: AnimalPhotoViewModel!
    private var useCase: MockAnimalPhotoUseCase!
    
    override func setUpWithError() throws {
        useCase = .init()
        sut = .init(animal: Animal.fakeAnimal, category: AnimalCategory.fakeAnimalCategory, useCase: useCase)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_onLoad_shouldLoadPhotosSuccesfully() async throws {
        useCase.getFavoritePhotoByCategoryHandler = { _ in
            return [AnimalPhoto.fakePhoto]
        }
        
        useCase.findAnimalPhotoHandler = { _, _ in
            return AnimalPhoto.fakePhotos
        }
        
        await sut.onLoad()
        
        XCTAssertEqual(sut.photoResult, .success(AnimalPhoto.fakePhotos))
        XCTAssertEqual(sut.favoritePhoto, [AnimalPhoto.fakePhoto])
    }
    
    func test_onLoadError_shouldShowError() async throws {
        useCase.getFavoritePhotoByCategoryHandler = { _ in
            throw NetworkError.unknown
        }
        useCase.findAnimalPhotoHandler = { _, _ in
            throw NetworkError.unknown
        }
        
        await sut.onLoad()
        
        XCTAssertEqual(sut.photoResult, .error)
        XCTAssertEqual(sut.favoritePhoto, [])
    }
    
    func test_findNextPhoto_shouldReturnNextPhotos() async {
        useCase.findAnimalPhotoHandler = { _, page in
            if page == 2 {
                return AnimalPhoto.fakePhotos
            } else {
                throw NSError(domain: "animalPhoto", code: 1)
            }
        }
        
        await sut.findNextPhoto()
        
        XCTAssertEqual(sut.photoResult, .success(AnimalPhoto.fakePhotos))
    }
    
    func test_addFavoriteTapped_shouldAddPhotoToFavoriteList() async {
        sut.addFavoriteTapped(photo: AnimalPhoto.fakePhoto)
        
        XCTAssertEqual(useCase.addPhotoToFavoriteCallCount, 1)
    }
    
    func test_removeFavoriteTapped_shouldRemovePhotoFromFavoriteList() async {
        sut.removeFavoriteTapped(photo: AnimalPhoto.fakePhoto)
        
        XCTAssertEqual(useCase.removePhotoFromFavoriteCallCount, 1)
    }
}
