//
//  PersistenceController.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/07.
//

import Foundation
import CoreData

fileprivate let DataModelName = "YrStone"

struct PersistenceController {
    static let shared = PersistenceController()
    static var preview: PersistenceController = {
        let persistenceInstance = PersistenceController(inMemory: true)
        let viewContext = persistenceInstance.container.viewContext
        return persistenceInstance
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: DataModelName)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { desc, error in
            if let err = error as NSError? {
                fatalError("failed to load persistent store: \(DataModelName)(\(desc)), \(err.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    let container : NSPersistentContainer
}
