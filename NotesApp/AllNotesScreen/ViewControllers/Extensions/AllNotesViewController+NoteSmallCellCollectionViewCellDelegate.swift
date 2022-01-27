//
//  AllNotesViewController+NoteSmallCellCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: NoteSmallCellCollectionViewCellDelegate {
    func didTapDelete(for noteViewModel: NoteCellViewModel) {
        coordinator?.presentSingleActionAlert(for: .onDeletingItem, { [weak self] in
            guard let self = self else { return }
            do {
                try self.noteRepository.deleteNote(noteViewModel.note)
            } catch {
                self.presentErrorAlert(with: "An error Occured deleting the item!")
            }
        })
    }
    
    func didTapShare(for noteViewModel: NoteCellViewModel) {
        coordinator?.shareNote(noteViewModel.note)
    }
    
    func didTapEdit(for noteViewModel: NoteCellViewModel) {
        coordinator?.editNote(with: noteViewModel.note.noteID)
    }
}
