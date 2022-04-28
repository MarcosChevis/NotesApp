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
    func createEmptyNote(shouldScroll: Bool) throws -> NoteProtocol
    func getInitialData() throws -> [NoteCellViewModel]
    func saveChangesWithoutEmptyNotes()
    func filterForTag(_ tag: TagProtocol) throws -> [NoteCellViewModel]
    func filterForContent(_ content: String) -> [NoteCellViewModel]
}

protocol NoteRepositoryProtocolDelegate: AnyObject {
    func didInsertNote(_ note: NoteCellViewModel, shouldScroll: Bool)
    func didDeleteNote(_ note: NoteCellViewModel)
    
}
