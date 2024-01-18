//
//  AnimalRepository.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import Foundation

protocol AnimalRepository {
    func getAnimalCategory() async throws -> [AnimalCategory]
    func findAnimal(name: String) async throws -> [Animal]
}


class AnimalRepositoryImpl: AnimalRepository {
    
    static func create() -> AnimalRepositoryImpl {
        return AnimalRepositoryImpl(networkClient: NetworkClientImpl(), storage: LocalStorageManager.shared)
    }
    
    private let networkClient: NetworkClient
    private let storage: LocalStorageManager
    
    init(networkClient: NetworkClient, storage: LocalStorageManager) {
        self.networkClient = networkClient
        self.storage = storage
    }
    
    func getAnimalCategory() async throws -> [AnimalCategory] {
        
        if AnimalCategoryModel.isEmpty() {
            let animalCategoryData: [[String: Any]] = [
                ["name": "Elephant", "imageName": "IconElephant"],
                ["name": "Lion", "imageName": "IconLion"],
                ["name": "Fox", "imageName": "IconFox"],
                ["name": "Dog", "imageName": "IconDog"],
                ["name": "Shark", "imageName": "IconShark"],
                ["name": "Turtle", "imageName": "IconTurtle"],
                ["name": "Whale", "imageName": "IconWhale"],
                ["name": "Penguin", "imageName": "IconPenguin"],
            ]
            try await AnimalCategoryModel.insertBatch(animalCategoryData)
        }
        
        let animalCategory: [AnimalCategoryModel] = AnimalCategoryModel.getAllCategory()
        return animalCategory.map { $0.toEntity() }
    }
    
    func findAnimal(name: String) async throws -> [Animal] {
        let urlProvider: APINinjasURLProvider = .animals(name: name)
        let response: [AnimalResponse] = try await networkClient.get(from: urlProvider)
        return response.map { $0.toEntity() }
    }
}
