//
//  CoreDataManager.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func saveUserDetails(_ user: UserDetails) {
        clearUserDetails()
        
        let entity = CDUserDetail(context: context)
        entity.name = user.name
        entity.email = user.email
        
        do {
            try context.save()
            print("UserDetails saved to Core Data")
        } catch {
            print("Failed to save UserDetails: \(error.localizedDescription)")
        }
    }
    
    func clearUserDetails() {
        let request: NSFetchRequest<CDUserDetail> = CDUserDetail.fetchRequest()
        do {
            let users = try context.fetch(request)
            users.forEach { context.delete($0) }
            try context.save()
        } catch {
            print("Failed to clear user details: \(error.localizedDescription)")
        }
    }
    
    
    func save(items: [APIObjetItems]) {
        clearOldData()
        print(items)
        for item in items {
            let entity = CDObjectItem(context: context)
            entity.id = item.id
            entity.name = item.name
            entity.color = item.data?.color
            entity.capacity = item.data?.capacity
            entity.capacityGB = Int64(item.data?.capacityGB ?? 0)
            entity.price = item.data?.price ?? 0
            entity.generation = item.data?.generation
            entity.year = Int64(item.data?.year ?? 0)
            entity.cpuModel = item.data?.cpuModel
            entity.hardDiskSize = item.data?.hardDiskSize
            entity.strapColour = item.data?.strapColour
            entity.caseSize = item.data?.caseSize
            entity.screenSize = item.data?.screenSize ?? 0
            entity.desc = item.data?.description
        }
        
        do {
            try context.save()
            print("CoreData saved successfully")
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
    
    func fetchItems() -> [CDObjectItem] {
        let request: NSFetchRequest<CDObjectItem> = CDObjectItem.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    func clearOldData() {
        let entityName = CDObjectItem.entity().name ?? "CDObjectItem"
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
            if let objectIDs = result?.result as? [NSManagedObjectID] {
                let changes = [NSDeletedObjectsKey: objectIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            }
            print("Old data cleared successfully.")
        } catch {
            print("Failed to clear old data: \(error.localizedDescription)")
        }
    }
    
    func updateItem(id: String, with newName: String) {
        let request: NSFetchRequest<CDObjectItem> = CDObjectItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(request)
            if let objectToUpdate = results.first {
                objectToUpdate.name = newName
                try context.save()
                print("Core Data item updated successfully")
            } else {
                print("No item found with id \(id)")
            }
        } catch {
            print("Failed to update item: \(error.localizedDescription)")
        }
    }
    
    func deleteItem(by id: String) {
        let request: NSFetchRequest<CDObjectItem> = CDObjectItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let item = try context.fetch(request).first {
                context.delete(item)
                try context.save()
                print("Item deleted successfully from Core Data.")
            } else {
                print("Item not found for deletion.")
            }
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }
}
