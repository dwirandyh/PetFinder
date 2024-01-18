//
//  AnimalPhotoViewModel.swift
//  PetFinder
//
//  Created by Dwi Randy H on 17/01/24.
//

import Foundation

@MainActor
class AnimalPhotoViewModel: ObservableObject {
    
    static func create(animal: Animal) -> AnimalPhotoViewModel {
        return AnimalPhotoViewModel(animal: animal, useCase: AnimalUseCaseImpl.create())
    }
    
    
    @Published
    private (set) var photoResult: DataResult<[AnimalPhoto]> = .loading
    
    private var photos: [AnimalPhoto] = []
    private var page: Int = 1
    private let animal: Animal
    private let useCase: AnimalUseCase
    
    init(animal: Animal, useCase: AnimalUseCase) {
        self.animal = animal
        self.useCase = useCase
    }
    
    func onLoad() async {
        do {
            photoResult = .loading
            
            let loadedPhotos: [AnimalPhoto] = try await useCase.findAnimalPhoto(keyword: animal.name, page: page)
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
            let loadedPhotos: [AnimalPhoto] = try await useCase.findAnimalPhoto(keyword: animal.name, page: page)
            photos.append(contentsOf: loadedPhotos)
            photoResult = .success(photos)
        } catch {
            
        }
    }
}
