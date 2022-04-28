//
//  NoteViewController+NoteRepositoryProtocolDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension NoteViewController: NoteRepositoryProtocolDelegate {
    func didInsertNote(_ note: NoteCellViewModel, shouldScroll: Bool) {
        insertNoteIntoDatasource(note, shouldScroll: shouldScroll)
    }
    
    func didDeleteNote(_ note: NoteCellViewModel) {
        deleteNoteIntoDatasource(note)
    }
}
