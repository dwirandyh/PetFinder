//
//  AnimalPhotoRepository.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import Foundation

protocol AnimalPhotoRepository {
    func addPhotoToFavorite(category: AnimalCategory, photo: AnimalPhoto) throws
    func removePhotoFromFavorite(photo: AnimalPhoto) throws
    func findAnimalPhoto(keyword: String, page: Int) async throws -> [AnimalPhoto]
    func getPhotoByCategory(category: AnimalCategory) -> [AnimalPhoto]
}

class AnimalPhotoRepositoryImpl: AnimalPhotoRepository {
    
    static func create() -> AnimalPhotoRepositoryImpl {
        return AnimalPhotoRepositoryImpl(networkClient: NetworkClientImpl(), storage: LocalStorageManager.shared)
    }
    
    private let networkClient: NetworkClient
    private let storage: LocalStorageManager
    
    init(networkClient: NetworkClient, storage: LocalStorageManager) {
        self.networkClient = networkClient
        self.storage = storage
    }
    
    func addPhotoToFavorite(category: AnimalCategory, photo: AnimalPhoto) throws {
        try FavoritePhotoModel.addToFavorite(category: category, photo: photo)
    }
    
    func removePhotoFromFavorite(photo: AnimalPhoto) throws {
        try FavoritePhotoModel.removeFromFavorite(photo: photo)
    }
    
    func findAnimalPhoto(keyword: String, page: Int) async throws -> [AnimalPhoto] {
        let urlProvider: PexelsURLProvider = .searchPhoto(keyword: keyword, page: page)
        let response: AnimalPhotoListResponse = try await networkClient.get(from: urlProvider)
        return response.photos.map { $0.toEntity() }
    }
    
    func getPhotoByCategory(category: AnimalCategory) -> [AnimalPhoto] {
        let photos = FavoritePhotoModel.getPhotoByCategory(category: category)
        return photos.map { $0.toEntity() }
    }
}
