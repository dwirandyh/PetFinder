//
//  AnimalRepository.swift
//  PetFinder
//
//  Created by Dwi Randy H on 16/01/24.
//

import Foundation

protocol AnimalRepository {
    func findAnimal(name: String) async throws -> [Animal]
}


class AnimalRepositoryImpl: AnimalRepository {
    
    static func create() -> AnimalRepositoryImpl {
        return AnimalRepositoryImpl(networkClient: NetworkClientImpl())
    }
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func findAnimal(name: String) async throws -> [Animal] {
        let urlProvider: APINinjasURLProvider = .animals(name: name)
        let response: [AnimalResponse] = try await networkClient.get(from: urlProvider)
        return response.map { $0.toEntity() }
    }
}
