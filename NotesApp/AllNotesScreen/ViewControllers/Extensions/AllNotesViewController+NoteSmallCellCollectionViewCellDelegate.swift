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
                self.coordinator?.presentErrorAlert(with: "An error Occured deleting the item!")
            }
        })
    }
    
    func didTapShare(for noteViewModel: NoteCellViewModel) {
        guard let content = noteViewModel.note.content, !content.isEmpty
        else {
            coordinator?.presentErrorAlert(with: "Your note is empty")
            return
        }
        
        coordinator?.shareContent(content)
    }
    
    func didTapEdit(for noteViewModel: NoteCellViewModel) {
        coordinator?.editNote(with: noteViewModel.note.noteID)
    }
}
