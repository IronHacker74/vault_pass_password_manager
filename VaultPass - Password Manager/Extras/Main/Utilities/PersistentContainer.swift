//
//  PersistentContainer.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 8/5/23.
//

import CoreData

class PersistentContainer: NSPersistentContainer {
    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
        let url = URL.storeURL(for: "group.vaultpass.masters", databaseName: "Model")
        let persistentStoreDescription = NSPersistentStoreDescription(url: url)
        self.persistentStoreDescriptions = [persistentStoreDescription]
        self.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
}

final class DefaultContainer {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
}
