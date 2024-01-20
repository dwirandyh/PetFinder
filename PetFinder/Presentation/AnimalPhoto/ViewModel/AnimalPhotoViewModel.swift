//
//  AnimalPhotoViewModel.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import Foundation

@MainActor
class AnimalPhotoViewModel: ObservableObject {
    
    static func create(animal: Animal, category: AnimalCategory) -> AnimalPhotoViewModel {
        return AnimalPhotoViewModel(animal: animal, category: category, useCase: AnimalPhotoUseCaseImpl.create())
    }
    
    @Published
    private (set) var photoResult: DataResult<[AnimalPhoto]> = .loading
    @Published
    private (set) var favoritePhoto: [AnimalPhoto] = []
    
    private var photos: [AnimalPhoto] = []
    private var page: Int = 1
    private let animal: Animal
    private let category: AnimalCategory
    private let useCase: AnimalPhotoUseCase
    
    init(animal: Animal, category: AnimalCategory, useCase: AnimalPhotoUseCase) {
        self.animal = animal
        self.category = category
        self.useCase = useCase
    }
    
    func onLoad() async {
        do {
            photoResult = .loading
            
            let loadedFavoritePhoto = try useCase.getFavoritePhotoByCategory(category: category)
            favoritePhoto = loadedFavoritePhoto
            
            let loadedPhotos: [AnimalPhoto] = try await useCase.findAnimalPhoto(animal: animal, page: page)
            photos.append(contentsOf: loadedPhotos)
            photoResult = .success(photos)
        }
        catch {
            photoResult = .error
        }
    }
    
    func findNextPhoto() async {
        page += 1
        do {
            let loadedPhotos: [AnimalPhoto] = try await useCase.findAnimalPhoto(animal: animal, page: page)
            photos.append(contentsOf: loadedPhotos)
            photoResult = .success(photos)
        } catch { }
    }
    
    func addFavoriteTapped(photo: AnimalPhoto) {
        do {
            try useCase.addPhotoToFavorite(category: category, photo: photo)
            favoritePhoto.append(photo)
        } catch { }
    }
    
    func removeFavoriteTapped(photo: AnimalPhoto) {
        do {
            try useCase.removePhotoFromFavorite(photo: photo)
            favoritePhoto.removeAll(where: { $0.id == photo.id })
        } catch { }
    }
}
