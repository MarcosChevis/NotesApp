//
//  NotesRepository.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import Foundation

class NotesRepository: NotesRepositoryProtocol {
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }
    
    func addNote(content: String) throws {
        let note: Note = Note(context: coreDataStack.mainContext)
        
        note.content = content
        note.modificationDate = Date()
        
        try coreDataStack.save()
    }
    
    func deleteNote(_ note: Note) throws {
        coreDataStack.mainContext.delete(note)
        try coreDataStack.save()
    }
    
    func editNote(_ note: Note) throws {
        note.modificationDate = Date()
        try coreDataStack.save()
    }
}
