//
//  NoteViewController+NoteViewDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension NoteViewController: NoteViewDelegate {
    func collectionDidShowCells(of indexPaths: [IndexPath]) {
        //print(indexPaths)
    }
    
    
    func collectionViewDidMove(to indexPath: IndexPath) {
        title = String(format: NSLocalizedString(.noteTitle), indexPath.row+1)
        
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            if indexPath == self.lastItemIndexPath {
                self.createNote(shouldScroll: false)
            }
        }
    }
    
    func didAllNotes() {
        navigateToAllNotes()
    }
    
    func didAdd() {
        scrollToFinalNote()
        
    }
    
}
