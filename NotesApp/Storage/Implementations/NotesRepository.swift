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
    private let isAscending: Bool
    
    private lazy var noteRequest: NSFetchRequest<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Note.creationDate, ascending: isAscending)]
        return fetchRequest
    }()
    
    weak var delegate: NoteRepositoryProtocolDelegate?
    
    init(coreDataStack: CoreDataStack = .shared, notificationService: NotificationService = NotificationCenter.default, isAscending: Bool = true) {
        self.coreDataStack = coreDataStack
        self.isAscending = isAscending
        self.cancelables = .init()
        self.notificationService = notificationService
        self.tagBuilder = TagBuilder {[weak coreDataStack] in
            guard let coreDataStack = coreDataStack else { return nil }
            return Tag(context: coreDataStack.mainContext)
        }
        super.init()
        setupBindings()
    }
    
    private func setupBindings() {
        notificationService.publisher(for: UIApplication.willResignActiveNotification, with: nil)
            .sink(receiveValue: triggerSave)
            .store(in: &cancelables)
    }
    
    private func triggerSave(_ notification: Notification) {
        do {
            removeEmptyObjects()
            try saveChanges()
        } catch {
            coreDataStack.mainContext.rollback()
        }
    }
    
    private var addedAndUncommitedNotes: [Note] {
        coreDataStack.mainContext.insertedObjects.compactMap { $0 as? Note } + coreDataStack.mainContext.updatedObjects.compactMap { $0 as? Note}
    }
    
    func saveChanges() throws {
        let tags = try coreDataStack.mainContext.fetch(Tag.fetchRequest())
        let newTags = tagBuilder.buildNewTags(for: addedAndUncommitedNotes, existingTags: tags)
        tagBuilder.updateExistingTags(tags + newTags, with: addedAndUncommitedNotes)
        try coreDataStack.save()
    }
    
    func deleteNote(_ note: NoteProtocol) throws {
        guard let note = note as? Note else {
            throw RepositoryError.incorrectObjectType
        }
        
        delegate?.deleteNote(.init(note: note))
        coreDataStack.mainContext.delete(note)
        
        guard let tags = note.tags?.allObjects as? [Tag] else {
            return
        }
        
        try saveChanges()
        
        tags.forEach {
            if $0.notes?.count == 0 {
                coreDataStack.mainContext.delete($0)
            }
        }
    }
    
    func createEmptyNote() throws -> NoteProtocol {
        let note = Note(context: coreDataStack.mainContext)
        note.content = ""
        note.title = ""
        delegate?.insertNote(NoteCellViewModel(note: note))
        return note
    }
    
    func getInitialData() throws -> [NoteCellViewModel] {
        let notes = try coreDataStack.mainContext.fetch(noteRequest)
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
        guard let notes = try? coreDataStack.mainContext.fetch(noteRequest) else { return }
        let emptyNotes = notes.filter {
            guard let content = $0.content else {
                return true
            }
            return content.isEmpty
        }
        emptyNotes.forEach {
            delegate?.deleteNote(.init(note: $0))
            coreDataStack.mainContext.delete($0)
        }
    }
    
    func filterForContent(_ content: String) -> [NoteCellViewModel] {
        let upperCasedContent = content.uppercased()
        let allNotes = (try? coreDataStack.mainContext.fetch(noteRequest)) ?? []
        
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
        let notes = try getInitialData()
        let filteredNotes = notes.filter { $0.note.allTags.first { $0.tagID == tag.tagID } != nil  }
        return filteredNotes
    }
}

enum RepositoryError: Error {
    case noObjectForID, incorrectObjectType, errorFetchingObjects
}
