//
//  CoreDataStack.swift
//  NotesApp
//
//  Created by Marcos Chevis on 22/07/21.
//
import CoreData

class CoreDataStack {

    static let shared = CoreDataStack()
    
    private static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: CoreDataStack.self)
        let containerName = "NotesModel"
        guard let url = bundle.url(forResource: containerName, withExtension: "momd") else {
            fatalError("Failed to find file")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load file")
        }
        return model
    }()

    private let model: String

    private var container: NSPersistentContainer

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(_ storeType: StoreType = .persistent) {
        self.model = "NotesModel"
        container = NSPersistentContainer(name: model, managedObjectModel: Self.managedObjectModel) // quando se refere as coisas estaticas da classe
        
        if storeType == .inMemory { // quando recebe esse endereco, eh pra guardar em memoria
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed loading with error: \(error)")
            }
        }
    }

    func save() throws {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                throw CoreDataStackError.failedToSave
            }
        } else {
            throw CoreDataStackError.contextHasNoChanges
        }
    }
    
    func createNote(content: String) -> Note {
        let note: Note = Note(context: mainContext)
        
        note.content = content
        note.modificationDate = Date()
        
        return note
    }
    
    func delete(note: Note) {
        mainContext.delete(note)
    }
}



enum CoreDataStackError: Error {
    case failedToSave
    case contextHasNoChanges
}

enum StoreType {
    case persistent
    case inMemory
}
