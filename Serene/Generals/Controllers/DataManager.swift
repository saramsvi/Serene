//
//  DataManager.swift
//  Serene
//
//  Created by MSVI on 28.04.22.
//

import Foundation
import CoreData

class DataManager {
   static  let shared = DataManager()
    lazy var persistentContainer: NSPersistentContainer  = {
       
            let container = NSPersistentContainer(name: "Serene")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

        func save() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                    print("Saved successfully!")
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

    func delete(object: NSManagedObject){
        let context = persistentContainer.viewContext
        do {
            context.delete(object)
            try context.save()
            print("Deleted successfully!")
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo), cannot delete.")
        }
    }
    
//    func account(name: String , surname: String , profileImage: Data , username: String, userSince: Date) -> Account {
//      let account = Account(context: persistentContainer.viewContext)
//        account.name = name
//        account.surname = surname
//        account.profileImage = profileImage
//        account.userID = username
//        account.userSince = userSince
//        return account
//    }
//    
//    func accounts() -> [Account]{
//        let request : NSFetchRequest<Account> = Account.fetchRequest()
//        var fetchedAccounts : [Account] = []
//        do{
//            fetchedAccounts = try persistentContainer.viewContext.fetch(request)
//        }
//        catch{
//            print("Error fetching projects!")
//        }
//        return fetchedAccounts
//    }
//
//    
  
    
}

