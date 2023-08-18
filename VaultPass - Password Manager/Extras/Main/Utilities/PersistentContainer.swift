//
//  PersistentContainer.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 8/5/23.
//

import CoreData

class PersistentContainer: NSPersistentCloudKitContainer {
    private let modelName: String = "Model"
    private let appGroupIdentifier = "group.vaultpass.masters"
    private let cloudContainer = "iCloud.VaultPassStorage"
    
    init(iCloud enableiCloud: Bool) {
        var model: NSManagedObjectModel = NSManagedObjectModel()
        if let url = Bundle.main.url(forResource: self.modelName, withExtension: "momd"), let setModel = NSManagedObjectModel(contentsOf: url) {
            model = setModel
        }
        super.init(name: self.modelName, managedObjectModel: model)
        let url = URL.storeURL(for: self.appGroupIdentifier, databaseName: self.modelName)
        let persistentStoreDescription = NSPersistentStoreDescription(url: url)
        if enableiCloud {
            persistentStoreDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: self.cloudContainer)
            self.viewContext.automaticallyMergesChangesFromParent = true
            self.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
            try? self.viewContext.setQueryGenerationFrom(.current)
        } else {
            persistentStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        }


        self.persistentStoreDescriptions = [persistentStoreDescription]
        self.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
}
