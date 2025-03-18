//
//  CoreDataManager.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 17.03.2025.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "BookSearching")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func addBook(newBook: Book) {
        let context = persistentContainer.viewContext
        
        if isLiked(newBook) {
            deleteBook(book: newBook)
        } else {
            
            let newBookDB = BookDB(context: context)
            newBookDB.author_key = newBook.authorKey.first ?? "unkonwn author key"
            newBookDB.author_name = newBook.authorName.first ?? "unkonwn author"
            newBookDB.title = newBook.title
            newBookDB.work_key = newBook.key
            newBookDB.cover_id = Int32(newBook.coverI ?? 0)
            
            saveContext()
        }
    }
    
    func deleteBook(book: Book) {
        let context = persistentContainer.viewContext
        let request = BookDB.fetchRequest()
        let predicate = NSPredicate(format: "work_key LIKE %@", book.key)
        
        request.predicate = predicate
        
        do {
            let results = try context.fetch(request)
            let existingBook = results.first!
            print(existingBook)
            context.delete(existingBook)
            
            saveContext()
        } catch { return }
    }
    
    func isLiked(_ book : Book) -> Bool {
        let request = BookDB.fetchRequest()
        let predicate = NSPredicate(format: "work_key LIKE %@", book.key)
        
        request.predicate = predicate
        
        let context = persistentContainer.viewContext
        
        do {
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            return false
        }
    }
    
    func getBooks() -> [Book] {
        let request = BookDB.fetchRequest()
        var books: [Book] = []
        
        let context = persistentContainer.viewContext
        
        do {
            let results = try context.fetch(request)
            results.forEach { it in
                books.append(it.makeBook())
            }
            return books
        } catch {
            return []
        }
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
