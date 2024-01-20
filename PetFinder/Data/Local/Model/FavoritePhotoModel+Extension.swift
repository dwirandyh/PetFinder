//
//  FavoritePhotoModel+Extension.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import Foundation
import CoreData

extension FavoritePhotoModel {
    func toEntity() -> AnimalPhoto {
        return AnimalPhoto(
            id: Int(id),
            photographer: photographer ?? "",
            photographerURL: URL(string: photographerURL ?? ""),
            source: AnimalPhoto.PhotoSource(
                original: photoSource?.original ?? "",
                large: photoSource?.large ?? "",
                medium: photoSource?.medium ?? "",
                small: photoSource?.small ?? "",
                portrait: photoSource?.portrait ?? "",
                landscape: photoSource?.landscape ?? "",
                tiny: photoSource?.tiny ?? ""
            )
        )
    }
}

extension FavoritePhotoModel {
    static func addToFavorite(category: AnimalCategory, photo: AnimalPhoto) throws {
        let animalCategoryModel = AnimalCategoryModel.find(name: category.name)
        
        let favoritePhotoModel = FavoritePhotoModel(context: LocalStorageManager.shared.viewContenxt)
        favoritePhotoModel.id = Int32(photo.id)
        favoritePhotoModel.photographer = photo.photographer
        favoritePhotoModel.photographerURL = photo.photographerURL?.absoluteString
        
        let photoSource = PhotoSourceModel(context: LocalStorageManager.shared.viewContenxt)
        photoSource.original = photo.source.original
        photoSource.large = photo.source.large
        photoSource.medium = photo.source.medium
        photoSource.small = photo.source.small
        photoSource.portrait = photo.source.portrait
        photoSource.landscape = photo.source.landscape
        photoSource.tiny = photo.source.tiny
        
        favoritePhotoModel.photoSource = photoSource
        
        animalCategoryModel?.addToFavoritePhotos(favoritePhotoModel)
        
        do {
            try LocalStorageManager.shared.viewContenxt.save()
        }
        catch {
            LocalStorageManager.shared.viewContenxt.rollback()
            throw error
        }
    }
    
    static func removeFromFavorite(photo: AnimalPhoto) throws {
        let request = FavoritePhotoModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %i", Int32(photo.id))
        
        do {
            let favoritePhotos = try LocalStorageManager.shared.viewContenxt.fetch(request)
            if let favorite = favoritePhotos.first {
                LocalStorageManager.shared.viewContenxt.delete(favorite)
                
                try LocalStorageManager.shared.viewContenxt.save()
            }
        } catch {
            LocalStorageManager.shared.viewContenxt.rollback()
            throw error
        }
    }
    
    static func getPhotoByCategory(category: AnimalCategory) throws -> [FavoritePhotoModel] {
        let request = AnimalCategoryModel.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", category.name)
        
        do {
            let categories = try LocalStorageManager.shared.viewContenxt.fetch(request)
            if let category = categories.first {
                return category.favoritePhotos?.allObjects as? [FavoritePhotoModel] ?? []
            } else {
                return []
            }
        } catch {
            throw error
        }
    }
}
