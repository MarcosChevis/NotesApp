//
//  NotesRepository.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import Foundation
import CoreData
import Combine
import UIKit

class NotesRepository: NSObject, NotesRepositoryProtocol {
    func filterForTag(_ tag: TagProtocol) throws -> [NoteCellViewModel] {
        []
    }
    
    
    private let coreDataStack: CoreDataStack
    private var cancelables: Set<AnyCancellable>
    private let notificationService: NotificationService
    let fetchResultsController: NSFetchedResultsController<Note>
    
    weak var delegate: NoteRepositoryProtocolDelegate?
    
    init(coreDataStack: CoreDataStack = .shared, notificationService: NotificationService = NotificationCenter.default) {
        self.coreDataStack = coreDataStack
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Note.creationDate, ascending: true)]
        
        let fetchResultsController: NSFetchedResultsController<Note> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchResultsController = fetchResultsController
        self.cancelables = .init()
        self.notificationService = notificationService
        super.init()
        fetchResultsController.delegate = self
        setupBindings()
    }
    
    func saveChanges() throws {
        try coreDataStack.save()
    }
    
    func deleteNote(_ note: NoteProtocol) throws {
        guard let note = note as? Note else {
            throw RepositoryError.incorrectObjectType
        }
        
        coreDataStack.mainContext.delete(note)
        try saveChanges()
    }
    
    func createEmptyNote() throws -> NoteProtocol {
        let note = Note(context: coreDataStack.mainContext)
        note.content = ""
        note.title = ""
        try saveChanges()
        return note
    }
    
    func getInitialData() throws -> [NoteCellViewModel] {
        try fetchResultsController.performFetch()
        
        guard let notes = fetchResultsController.fetchedObjects else {
            throw RepositoryError.errorFetchingObjects
        }
        
        let viewModels = notes.map(NoteCellViewModel.init)
        return viewModels
    }
    
    private func setupBindings() {
        notificationService.publisher(for: .saveChanges, with: nil)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.current, options: .none)
            .receive(on: RunLoop.main)
            .sink(receiveValue: triggerSave)
            .store(in: &cancelables)
        
        notificationService.publisher(for: UIApplication.willResignActiveNotification, with: nil)
            .sink(receiveValue: removeEmptyAndSaveNotification)
            .store(in: &cancelables)
    }
    
    private func triggerSave(_ notification: Notification) {
        do {
            try saveChanges()
        } catch {
            coreDataStack.mainContext.rollback()
        }
    }
    
    private func removeEmptyAndSaveNotification(_ notification: Notification) {
        saveChangesWithoutEmptyNotes()
    }
    
    func saveChangesWithoutEmptyNotes() {
        do {
            removeEmptyObjects()
            try saveChanges()
        } catch {
            coreDataStack.mainContext.rollback()
        }
    }
    
    private func removeEmptyObjects() {
        guard let notes = fetchResultsController.fetchedObjects else { return }
        let emptyNotes = notes.filter {
            guard let content = $0.content else {
                return true
            }
            return content.isEmpty
        }
        emptyNotes.forEach { coreDataStack.mainContext.delete($0) }
    }

}

enum RepositoryError: Error {
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
//        guard let note = note, let indexPath = indexPath else {
//            return
//        }
        
    }
}
