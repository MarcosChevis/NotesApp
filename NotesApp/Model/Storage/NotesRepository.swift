//
//  NotesRepository.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import Foundation
import CoreData

class NotesRepository {
    private let coreDataStack: CoreDataStack
    let fetchResultsController: NSFetchedResultsController<Note>
    
    var numberOfElements: Int {
        guard let elements = fetchResultsController.fetchedObjects else {
            return 0
        }
        
        return elements.count
    }
    
    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Note.creationDate, ascending: true)]
        
        let fetchResultsController: NSFetchedResultsController<Note> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchResultsController = fetchResultsController
    }
    
    func addNote(content: String) throws {
        let note: Note = Note(context: coreDataStack.mainContext)
        
        note.content = content
        note.modificationDate = Date()
        
        try coreDataStack.save()
    }
    
    func deleteNote(_ id: URL) throws {
        let note = try getNoteFromURL(id)
        
        coreDataStack.mainContext.delete(note)
        try coreDataStack.save()
    }
    
    func editNote(with viewModel: NoteCellViewModel) throws {
        guard let id = viewModel.id else {
            throw NoteRepositoryError.noObjectForID
        }
        
        let note = try getNoteFromURL(id)
        note.content = viewModel.content
        
        note.modificationDate = Date()
        try coreDataStack.save()
    }
    
    private func getNoteFromURL(_ url: URL) throws -> Note {
        guard let id = coreDataStack.convertURLToObjectID(url) else {
            throw NoteRepositoryError.noObjectForID
        }
        
        guard let note = coreDataStack.mainContext.object(with: id) as? Note else {
            throw NoteRepositoryError.incorrectObjectType
        }
        
        return note
    }
    
    @discardableResult
    func generatePermanentsIds() -> Bool {
        guard let notes = fetchResultsController.fetchedObjects else {
            return false
        }
        
        do {
            try coreDataStack.mainContext.obtainPermanentIDs(for: notes)
            return true
        } catch  {
            return false
        }
    }
}

enum NoteRepositoryError: Error {
    case noObjectForID, incorrectObjectType
}
