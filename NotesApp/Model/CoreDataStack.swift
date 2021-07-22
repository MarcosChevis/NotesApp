//
//  CoreDataStack.swift
//  NotesApp
//
//  Created by Marcos Chevis on 22/07/21.
//
import CoreData

class CoreDataStack {

    static let shared = CoreDataStack()

    private let model: String

    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.model)
        let defaultURL = NSPersistentContainer.defaultDirectoryURL()
        let sqliteURL = defaultURL.appendingPathComponent("\(self.model).sqlite")

        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent store: \(error.localizedDescription)")
            }
        }

        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    private init(model: String = "NotesModel") {
        self.model = model
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
    
    func edit(note: Note) {
        
    }
    
    func delete(note: Note) {
        mainContext.delete(note)
    }
}

enum CoreDataStackError: Error {
    case failedToSave
    case contextHasNoChanges
}
