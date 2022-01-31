//
//  NoteViewController+NoteViewDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension NoteViewController: NoteViewDelegate {
    
    func collectionViewDidMove(to indexPath: IndexPath) {
        guard let note = dataSource.itemIdentifier(for: indexPath)?.note,
              currentHighlightedNote?.noteID != note.noteID || currentHighlightedNote == nil else {
                  return
              }
        
        currentHighlightedNote = note
        title = "Page \(indexPath.row+1)"
    }
    
    func didDelete() {
        coordinator?.presentSingleActionAlert(for: .onDeletingItem) { [weak self] in
            guard let self = self else { return }
            self.deleteNote()
        }
    }
    
    func didAllNotes() {
        repository.saveChangesWithoutEmptyNotes()
        coordinator?.navigateToAllNotes()
        
    }
    
    func didAdd() {
        do {
            _ = try repository.createEmptyNote()
        } catch {
            coordinator?.presentErrorAlert(with: "An error occured trying to add an note")
        }
    }
    
    func didShare() {
        guard let currentHighlightedNote = self.currentHighlightedNote else {
            coordinator?.presentErrorAlert(with: "You do not have notes to share")
            return
        }
        
        guard let content = currentHighlightedNote.content, !content.isEmpty else {
            coordinator?.presentErrorAlert(with: "Your note is empty")
            return
        }
        
        coordinator?.shareContent(content)
    }
}
