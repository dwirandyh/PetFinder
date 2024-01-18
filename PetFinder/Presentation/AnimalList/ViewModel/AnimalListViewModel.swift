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
    private (set) var animalsResult: DataResult<[Animal]> = .loading
    @Published
    private (set) var animalCategory: [AnimalCategory] = []
    @Published
    private (set) var selectedAnimalCategory: AnimalCategory?
    
    private let useCase: AnimalUseCase
    
    init(useCase: AnimalUseCase) {
        self.useCase = useCase
    }
    
    func onLoad() async {
        do {
            animalCategory = try await useCase.getAnimalCategory()
            
            guard let defaultCategory = animalCategory.first else { return }
            selectedAnimalCategory = defaultCategory
            let animals = try await useCase.findAnimal(name: defaultCategory.name)
            animalsResult = .success(animals)
        } catch {
            animalsResult = .error
        }
    }
    
    func animalCategoryDidChange(category: AnimalCategory) async {
        selectedAnimalCategory = category
        do {
            animalsResult = .loading
            let animals = try await useCase.findAnimal(name: category.name)
            animalsResult = .success(animals)
        } catch {
            animalsResult = .error
        }
    }
}
