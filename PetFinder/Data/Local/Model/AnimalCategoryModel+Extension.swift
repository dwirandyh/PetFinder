//
//  AnimalCategoryModel+Operation.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import Foundation
import CoreData

extension AnimalCategoryModel {
    func toEntity() -> AnimalCategory {
        return AnimalCategory(name: name ?? "", imageName: imageName ?? "")
    }
}

extension AnimalCategoryModel {
    static func find(name: String) -> AnimalCategoryModel? {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try LocalStorageManager.shared.viewContenxt.fetch(request)
            
            if let firstObject = result.first {
                return firstObject
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    static func saveAnimalCategory(category: String, imageName: String) {
        let animalCategory: AnimalCategoryModel = AnimalCategoryModel(context: LocalStorageManager.shared.viewContenxt)
        animalCategory.name = category
        animalCategory.imageName = imageName
        
        do {
            try LocalStorageManager.shared.viewContenxt.save()
        } catch {
            LocalStorageManager.shared.viewContenxt.rollback()
        }
    }
    
    static func isEmpty() -> Bool {
        let fetchRequest: NSFetchRequest = AnimalCategoryModel.fetchRequest()
        
        do {
            let rowCount = try LocalStorageManager.shared.viewContenxt.count(for: fetchRequest)
            return rowCount == 0
        } catch {
            return true
        }
    }
    
    static func insertBatch(_ data: [[String : Any]]) async throws {
        let batchRequest: NSBatchInsertRequest = NSBatchInsertRequest(entity: AnimalCategoryModel.entity(), objects: data)
        
        try await LocalStorageManager.shared.insertBatch(request: batchRequest)
    }
    
    static func getAllCategory() -> [AnimalCategoryModel]  {
        let fetchRequest = AnimalCategoryModel.fetchRequest()
        do {
            return try LocalStorageManager.shared.viewContenxt.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
