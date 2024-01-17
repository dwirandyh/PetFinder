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
        return AnimalPhotoViewModel(animal: animal, repository: AnimalRepositoryImpl.create())
    }
    
    @Published
    private (set) var photos: [AnimalPhoto] = []
    @Published
    var isLoading: Bool = false
    
    private var page: Int = 1
    private let animal: Animal
    private let repository: AnimalRepository
    
    init(animal: Animal, repository: AnimalRepository) {
        self.animal = animal
        self.repository = repository
    }
    
    func findAnimalPhoto() async {
        do {
            isLoading = true
            
            let loadedPhotos: [AnimalPhoto] = try await repository.findAnimalPhoto(keyword: animal.name, page: page)
            photos.append(contentsOf: loadedPhotos)
            
            isLoading = false
        }
        catch {
            isLoading = false
        }
    }
    
    func findNextPhoto() async {
        page += 1
        await findAnimalPhoto()
    }
}
