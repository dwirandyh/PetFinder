//
//  FavoriteViewModel.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import Foundation

@MainActor
class FavoriteViewModel: ObservableObject {
    
    static func create() -> FavoriteViewModel {
        return FavoriteViewModel(animalPhotoUseCase: AnimalPhotoUseCaseImpl.create(), animalUseCase: AnimalUseCaseImpl.create())
    }
    
    @Published
    private (set) var animalPhotoResult: DataResult<[AnimalPhoto]> = .loading
    @Published
    private (set) var animalCategory: [AnimalCategory] = []
    @Published
    private (set) var selectedAnimalCategory: AnimalCategory?
    
    private let animalPhotoUseCase: AnimalPhotoUseCase
    private let animalUseCase: AnimalUseCase
    
    init(animalPhotoUseCase: AnimalPhotoUseCase, animalUseCase: AnimalUseCase) {
        self.animalPhotoUseCase = animalPhotoUseCase
        self.animalUseCase = animalUseCase
    }
    
    func onLoad() async {
        do {
            animalCategory = try await animalUseCase.getAnimalCategory()
            
            guard let defaultCategory = animalCategory.first else { return }
            selectedAnimalCategory = defaultCategory
            refreshData()
        } catch {
            animalPhotoResult = .error
        }
    }
    
    func refreshData() {
        guard let selectedAnimalCategory else { return }
        do {
            let photos = try animalPhotoUseCase.getFavoritePhotoByCategory(category: selectedAnimalCategory)
            animalPhotoResult = .success(photos)
        } catch {
            animalPhotoResult = .error
        }
    }
    
    
    func animalCategoryDidChange(category: AnimalCategory) {
        selectedAnimalCategory = category
        do {
            let photos = try animalPhotoUseCase.getFavoritePhotoByCategory(category: category)
            animalPhotoResult = .success(photos)
        } catch {
            animalPhotoResult = .error
        }
    }
    
    func removeFavoriteTapped(photo: AnimalPhoto) {
        do {
            try animalPhotoUseCase.removePhotoFromFavorite(photo: photo)
            
            refreshData()
        }
        catch { }
    }
}
