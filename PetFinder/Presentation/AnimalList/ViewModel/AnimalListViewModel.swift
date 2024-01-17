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
        return AnimalListViewModel(useCase: AnimalUseCaseImpl.create())
    }
    
    @Published
    private (set) var animals: [Animal] = []
    @Published
    private (set) var selectedAnimalCategory: AnimalCategory = .defaultSelectedCategory
    
    private let useCase: AnimalUseCase
    
    init(useCase: AnimalUseCase) {
        self.useCase = useCase
    }
    
    func fetchAnimals(category: AnimalCategory) async {
        selectedAnimalCategory = category
        await fetchAnimals()
    }
    
    func fetchAnimals() async {
        do {
            animals = try await useCase.findAnimal(name: selectedAnimalCategory.name)
        }
        catch {
            print(error)
        }
    }
}
