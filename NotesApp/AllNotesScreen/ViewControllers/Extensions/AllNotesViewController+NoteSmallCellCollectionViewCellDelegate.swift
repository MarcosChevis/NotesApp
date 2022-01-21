//
//  AllNotesViewController+NoteSmallCellCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: NoteSmallCellCollectionViewCellDelegate {
    func didTapDelete(for noteViewModel: NoteCellViewModel) {
        presentAlert(for: .onDeletingItem, { [weak self] in
            guard let self = self else { return }
            self.deleteNote(noteViewModel)
        })
    }
    
    func didTapShare(for noteViewModel: NoteCellViewModel) {
        do {
            let shareScreen = try UIActivityViewController.shareNote(noteViewModel.note)
            present(shareScreen, animated: true, completion: nil)
        } catch {
            presentErrorAlert(with: "Your note is empty")
        }
        print("share")
    }
    
    func didTapEdit(for noteViewModel: NoteCellViewModel) {
        print("edit")
    }
}
