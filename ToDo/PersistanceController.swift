//
//  PersistanceController.swift
//  ToDo
//
//  Created by Le Hen Hugo on 20/03/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container = NSPersistentContainer(name: "Note")

    init(inMemory: Bool = false) {
    
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
