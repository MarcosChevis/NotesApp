//
//  AllNotesViewController+AllNotesViewDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: AllNotesViewDelegate {
    func didTapSettings() {
        coordinator?.navigateToSettings()
    }
    
    func didTapAddNote() {
        do {
            _ = try noteRepository.createEmptyNote()
            
        } catch {
            print("erro")
            #warning("fazer o erro")
        }
    }
}
