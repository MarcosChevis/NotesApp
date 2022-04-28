//
//  AllNotesViewController+NoteRepositoryProtocolDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: NoteRepositoryProtocolDelegate {
    func didInsertNote(_ note: NoteCellViewModel, shouldScroll: Bool) {
        insertItem(.note(noteViewModel: note), at: .text)
    }
    
    func didDeleteNote(_ note: NoteCellViewModel) {
        deleteItem(.note(noteViewModel: note), at: .text)
    }
}
