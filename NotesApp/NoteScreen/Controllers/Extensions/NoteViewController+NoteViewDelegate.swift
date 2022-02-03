//
//  NoteViewController+NoteViewDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension NoteViewController: NoteViewDelegate {
    
    func collectionViewDidMove(to indexPath: IndexPath) {
        title = "Page \(indexPath.row+1)"
    }
    
    func didAllNotes() {
        navigateToAllNotes()
    }
    
    func didAdd() {
        createNote()
    }
    
}
