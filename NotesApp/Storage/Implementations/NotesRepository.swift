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
    private let coreDataStack: CoreDataStack
    private var cancelables: Set<AnyCancellable>
    private let notificationService: NotificationService
    private let tagBuilder: TagBuilder
    let fetchResultsController: NSFetchedResultsController<Note>
    
    weak var delegate: NoteRepositoryProtocolDelegate?
    
    init(coreDataStack: CoreDataStack = .shared, notificationService: NotificationService = NotificationCenter.default, isAscending: Bool = true) {
        self.coreDataStack = coreDataStack
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Note.creationDate, ascending: isAscending)]
        
        let noteFetchResultsController: NSFetchedResultsController<Note> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchResultsController = noteFetchResultsController
        self.cancelables = .init()
        self.notificationService = notificationService
        self.tagBuilder = TagBuilder {[weak coreDataStack] in
            guard let coreDataStack = coreDataStack else { return nil }
            return Tag(context: coreDataStack.mainContext)
        }
        super.init()
        noteFetchResultsController.delegate = self
        setupBindings()
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
            let tags = try coreDataStack.mainContext.fetch(Tag.fetchRequest())
            let newTags = tagBuilder.buildNewTags(for: addedAndUncommitedNotes, existingTags: tags)
            tagBuilder.updateExistingTags(tags + newTags, with: addedAndUncommitedNotes)
            try saveChanges()
            
        } catch {
            coreDataStack.mainContext.rollback()
        }
    }
    
    private var addedAndUncommitedNotes: [Note] {
        coreDataStack.mainContext.insertedObjects.compactMap { $0 as? Note } + coreDataStack.mainContext.updatedObjects.compactMap { $0 as? Note}
    }
    
    private func removeEmptyAndSaveNotification(_ notification: Notification) {
        saveChangesWithoutEmptyNotes()
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
    
    func filterForContent(_ content: String) -> [NoteCellViewModel] {
        let upperCasedContent = content.uppercased()
        let allNotes = fetchResultsController.fetchedObjects ?? []
        
        if content.isEmpty {
            return allNotes.map(NoteCellViewModel.init)
        }
        
        let filteredNotes = allNotes.filter { note in
            let upperCasedNoteContent = note.content?.uppercased()
            let upperCasedNoteTitle = note.title?.uppercased()
            let doesContainInContent = upperCasedNoteContent?.contains(upperCasedContent) ?? false
            let doesContainInTitle = upperCasedNoteTitle?.contains(upperCasedContent) ?? false
            return doesContainInTitle || doesContainInContent
        }
        
        return filteredNotes.map(NoteCellViewModel.init)
    }
    
    func filterForTag(_ tag: TagProtocol) throws -> [NoteCellViewModel] {
        []
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
            break
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
}
