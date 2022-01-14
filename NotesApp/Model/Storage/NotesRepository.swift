//
//  NotesRepository.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import Foundation
import CoreData
import UIKit

class NotesRepository: NSObject, NotesRepositoryProtocol {
    private let coreDataStack: CoreDataStack
    let fetchResultsController: NSFetchedResultsController<Note>
    
    weak var delegate: NoteRepositoryProtocolDelegate?
    
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
        super.init()
        fetchResultsController.delegate = self
    }
    
    func saveChanges() throws {
        try coreDataStack.save()
    }
    
    func deleteNote(_ note: NoteProtocol) throws {
        guard let note = note as? Note else {
            throw NoteRepositoryError.incorrectObjectType
        }
        
        coreDataStack.mainContext.delete(note)
        try saveChanges()
    }
    
    func createEmptyNote() throws -> NoteProtocol {
        let note = Note(context: coreDataStack.mainContext)
        try saveChanges()
        return note
    }
    
    func getInitialData() throws -> [NoteCellViewModel] {
        try fetchResultsController.performFetch()
        
        guard let notes = fetchResultsController.fetchedObjects else {
            throw NoteRepositoryError.errorFetchingObjects
        }
        
        let viewModels = notes.map(NoteCellViewModel.init)
        return viewModels
    }

}

enum NoteRepositoryError: Error {
    case noObjectForID, incorrectObjectType, errorFetchingObjects
}

extension NotesRepository: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            updateUIWithInsertNote(anObject as? Note, at: newIndexPath)
        case .delete:
            updateUIWithDeleteNote(anObject as? Note)
        case .move:
            break
        case .update:
            updateUIWithUpdateNote(anObject as? Note, at: indexPath)
        @unknown default:
            break
        }
    }
    
    private func updateUIWithInsertNote(_ note: Note?, at indexPath: IndexPath?) {
        guard let note = note, let indexPath = indexPath else {
            return
        }
        
        let viewModel = NoteCellViewModel(note: note)
        delegate?.insertNote(viewModel, at: indexPath)
    }
    
    private func updateUIWithDeleteNote(_ note: Note?) {
        guard let note = note else {
            return
        }
        
        delegate?.deleteNote(NoteCellViewModel(note: note))
    }
    
    private func updateUIWithUpdateNote(_ note: Note?, at indexPath: IndexPath?) {
        guard let note = note, let indexPath = indexPath else {
            return
        }
        
    }
}
