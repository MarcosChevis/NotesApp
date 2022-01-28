//
//  NoteRepositoryDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import Foundation
@testable import NotesApp

class NoteRepositoryDummy: NotesRepositoryProtocol {
    func filterForContent(_ content: String) -> [NoteCellViewModel] {
        []
    }
    
    var mock: [NoteCellViewModel] = []
    weak var delegate: NoteRepositoryProtocolDelegate?
    var didCallSaveChanges: Bool = false
    
    func saveChanges() throws {
        didCallSaveChanges = true
    }
    
    func deleteNote(_ note: NoteProtocol) throws {
        mock.removeAll(where: { $0.note.noteID == note.noteID })
        delegate?.deleteNote(.init(note: note))
    }
    
    func createEmptyNote() throws -> NoteProtocol {
        let vm = NoteCellViewModel.init(note: NoteDummy(noteID: UUID().uuidString, content: ""))
        delegate?.insertNote(vm, at: IndexPath(row: mock.count, section: 0))
        mock.append(vm)
        return vm.note
        
    }
    
    func getInitialData() throws -> [NoteCellViewModel] {
        mock
    }
    
    func filterForTag(_ tag: TagProtocol) throws -> [NoteCellViewModel] {
        []
    }
    
    func saveChangesWithoutEmptyNotes() {
        mock = mock.filter { !($0.note.content?.isEmpty ?? true) }
    }
    
}
