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
        print(note.noteID)
        
        title = "Page \(indexPath.row)"
    }
    
    func didDelete() {
        presentAlert(for: .onDeletingItem) { [weak self] in
            guard let self = self else { return }
            self.deleteNote()
        }
    }
    
    func didAllNotes() {
        print("coisas de all notes")
        
    }
    
    func didAdd() {
        do {
            _ = try repository.createEmptyNote()
        } catch {
            
        }
    }
    
    func didShare() {
        guard let currentHighlightedNote = self.currentHighlightedNote else {
            presentErrorAlert(with: "You do not have notes to share")
            return
        }
        
        do {
            let shareScreen = try UIActivityViewController.shareNote(currentHighlightedNote)
            present(shareScreen, animated: true, completion: nil)
        } catch {
            presentErrorAlert(with: "Your note is empty")
        }
        
    }
}