//
//  AllNotesViewController+NoteSmallCellCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: NoteSmallCellCollectionViewCellDelegate {
    func didTapDelete(for noteViewModel: NoteCellViewModel) {
        deleteNote(noteViewModel)
    }
    
    func didTapShare(for noteViewModel: NoteCellViewModel) {
        print("share")
    }
    
    func didTapEdit(for noteViewModel: NoteCellViewModel) {
        print("edit")
    }
}
