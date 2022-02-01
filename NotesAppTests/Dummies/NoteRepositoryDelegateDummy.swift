//
//  NoteRepositoryDelegateDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import Foundation
@testable import NotesApp

class NoteRepositoryDelegateDummy: NoteRepositoryProtocolDelegate {
    var data: [NoteCellViewModel] = []
    
    func didInsertNote(_ note: NoteCellViewModel) {
        data.append(note)
    }
    
    func didDeleteNote(_ note: NoteCellViewModel) {
        data = data.filter { $0.note.noteID != note.note.noteID }
    }
}
