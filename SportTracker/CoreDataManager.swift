import Foundation
import CoreData

final class CoreDataManager {
    
    private lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "SportTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // TODO: Handle core data error
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
   
    func getData<T: NSManagedObject>() throws -> [T] {
        guard let result = try persistentContainer.viewContext.fetch(T.fetchRequest()) as? [T] else { throw NetworkError.unknown }
        return result
    }
    
    func newObject<T: NSManagedObject>() -> T {
        return T(context: persistentContainer.viewContext)
    }
   
    func delete<T: NSManagedObject>(type: T.Type, where condition: (T)-> Bool) {
        if let data: [T] = try? getData(){
            data.forEach { item in
                guard condition(item) else { return }
                persistentContainer.viewContext.delete(item)
            }
        }
    }
    
    func delete<T: NSManagedObject>(index: Int, data: [T]) {
        let item = data[index]
        persistentContainer.viewContext.delete(item)
        saveContext()
    }
    
    func save() {
        saveContext()
    }
    
    private func saveContext() {
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
