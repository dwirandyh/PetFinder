//
//  AnimalListViewModel.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import Foundation

@MainActor
class AnimalListViewModel: ObservableObject {
    
    static func create() -> AnimalListViewModel {
        return AnimalListViewModel(repository: AnimalRepositoryImpl.create())
    }
    
    @Published
    var animals: [Animal] = []
    @Published
    var selectedAnimalCategory: AnimalCategory? = .defaultSelectedCategory
    
    private let repository: AnimalRepository
    
    init(repository: AnimalRepository) {
        self.repository = repository
        
        Task {
            await fetchAnimals(animalCategory: .defaultSelectedCategory)
        }
    }
    
    func fetchAnimals(animalCategory: AnimalCategory) async {
        do {
            selectedAnimalCategory = animalCategory
            animals = try await repository.findAnimal(name: animalCategory.name)
        }
        catch {
            print(error)
        }
    }
}
