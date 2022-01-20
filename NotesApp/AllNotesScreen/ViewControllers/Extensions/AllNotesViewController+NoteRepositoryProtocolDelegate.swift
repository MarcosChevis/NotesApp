//
//  AllNotesViewController+NoteRepositoryProtocolDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: NoteRepositoryProtocolDelegate {
    func insertNote(_ note: NoteCellViewModel, at indexPath: IndexPath) {
        insertItem(.note(noteViewModel: note), at: .text)
    }
    
    func deleteNote(_ note: NoteCellViewModel) {
        deleteItem(.note(noteViewModel: note), at: .text)
    }
}
