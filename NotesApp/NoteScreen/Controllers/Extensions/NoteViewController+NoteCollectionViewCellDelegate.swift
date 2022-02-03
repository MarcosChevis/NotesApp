//
//  NoteViewController+NoteCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 01/02/22.
//

import UIKit

extension NoteViewController: NoteCollectionViewCellDelegate {
    func didTapDeleteNote(_ viewModel: NoteCellViewModel) {
        deleteNote(viewModel.note)
    }
    
    func didTapShareNote(_ viewModel: NoteCellViewModel) {
        shareNote(viewModel.note)
    }
}
