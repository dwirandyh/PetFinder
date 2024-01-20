//
//  LocalStorageManager.swift
//  PetFinder
//
//  Created by Dwi Randy H on 18/01/24.
//

import CoreData

class LocalStorageManager {
    static let shared = LocalStorageManager()
    
    let persistentContainer: NSPersistentContainer
    
    var viewContenxt: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "PetFinderModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Dat store failed to load with error: \(error)")
            }
        }
    }
    
    @discardableResult
    func insertBatch(request: NSBatchInsertRequest) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            let backgroundContext = persistentContainer.newBackgroundContext()
            backgroundContext.perform {
                do {
                    request.resultType = .statusOnly
                    let result = try backgroundContext.execute(request) as? NSBatchInsertResult
                    if let succes = result?.result as? Bool, succes {
                        continuation.resume(returning: true)
                    } else {
                        continuation.resume(returning: false)
                    }
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
