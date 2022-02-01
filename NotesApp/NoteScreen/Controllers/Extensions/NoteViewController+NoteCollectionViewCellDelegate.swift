//
//  NoteViewController+NoteCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 01/02/22.
//

import UIKit

extension NoteViewController: NoteCollectionViewCellDelegate {
    func shareNote(_ viewModel: NoteCellViewModel) {
        guard let content = viewModel.note.content, !content.isEmpty else {
            coordinator?.presentErrorAlert(with: "Your note is empty")
            return
        }
        
        coordinator?.shareContent(content)
    }
    
    
    

}
