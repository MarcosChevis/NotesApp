//
//  AllNotesCoordinatorDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit
@testable import NotesApp

class AllNotesCoordinatorDummy: AllNotesCoordinatorProtocol {
    func navigateToCustomTheme() {
        
    }
    
    var didDismiss: Bool = false
    var didNavigateToSettings: Bool = false
    var didNavigateToThemes: Bool = false
    var didNavigateToEditNote: Bool = false
    var editedNote: String = ""
    var didPresentErrorAlert: Bool = false
    var didPresentSingleAlertAction: Bool = false
    var sharedNote: String? = nil
    
    func dismiss() {
        didDismiss = true
    }
    
    func navigateToSettings() {
        didNavigateToSettings = true
    }
    
    func navigateToThemes() {
        didNavigateToThemes = true
    }
    
    func editNote(with id: String) {
        editedNote = id
    }
    
    func presentSingleActionAlert(for alertCase: UIAlertController.CommonAlert, _ action: @escaping () -> Void) {
        didPresentSingleAlertAction = true
        action()
    }
    
    func presentErrorAlert(with message: String) {
        didPresentErrorAlert = true
    }
    
    func shareContent(_ content: String) {
        sharedNote = content
    }
}
