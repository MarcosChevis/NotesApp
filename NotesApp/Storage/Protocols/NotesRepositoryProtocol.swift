//
//  NotesRepositoryProtocol.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import Foundation

protocol NotesRepositoryProtocol: AnyObject {
    var delegate: NoteRepositoryProtocolDelegate? { get set }
    func saveChanges() throws
    func deleteNote(_ note: NoteProtocol) throws
    func createEmptyNote() throws -> NoteProtocol
    func getInitialData() throws -> [NoteCellViewModel]
    func saveChangesWithoutEmptyNotes()
    func filterForTag(_ tag: TagProtocol) throws -> [NoteCellViewModel]
    func filterForContent(_ content: String) -> [NoteCellViewModel]
}

protocol NoteRepositoryProtocolDelegate: AnyObject {
    func insertNote(_ note: NoteCellViewModel, at indexPath: IndexPath)
    func deleteNote(_ note: NoteCellViewModel)
    
}

