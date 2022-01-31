//
//  AllNotesViewController+AllNotesViewDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: AllNotesViewDelegate {
    func didTapClose() {
        coordinator?.dismiss()
    }
    
    func didTapSettings() {
        coordinator?.navigateToSettings()
    }
}
