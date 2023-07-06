//
//  Persistence.swift
//  KeDa-Tech-Test
//
//  Created by Vincent on 06/07/23.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.productName = PersistenceController.dataNameProduct[i]
            newItem.productDesc = "deskripsi \(PersistenceController.dataNameProduct[i])"
            newItem.productImage = PersistenceController.dataNameProduct[i]
            newItem.isFavorite = false
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    static let dataNameProduct: [String] = ["Pisang", "Apel", "Jeruk", "Nanas", "Anggur", "Melon", "Semangka", "Durian", "Sirsak", "Rambutan", "Ceri", "Stroberi", "Pir", "Pepaya", "Manggis"]

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "KeDa_Tech_Test")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        getRecordsCount()
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func getRecordsCount() {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
            let count = try context.count(for: fetchRequest)
            
            if count == 0 {
                for i in 0..<PersistenceController.dataNameProduct.count {
                    let newItem = Item(context: context)
                    newItem.productName = PersistenceController.dataNameProduct[i]
                    newItem.productDesc = "Deskripsi Buah \(PersistenceController.dataNameProduct[i])"
                    newItem.productImage = PersistenceController.dataNameProduct[i]
                    newItem.isFavorite = false
                }
                do {
                    try context.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
