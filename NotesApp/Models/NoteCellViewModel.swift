//
//  NoteCellViewModel.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 13/01/22.
//

import Foundation

class NoteCellViewModel {
    var note: NoteProtocol
    
    init(note: NoteProtocol) {
        self.note = note
    }
}

extension NoteCellViewModel: Hashable {
    static func == (lhs: NoteCellViewModel, rhs: NoteCellViewModel) -> Bool {
        lhs.note.noteID == rhs.note.noteID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(note.noteID)
        hasher.combine(note.content)
    }
}
