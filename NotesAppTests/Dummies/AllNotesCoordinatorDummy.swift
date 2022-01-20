//
//  AllNotesCoordinatorDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit
@testable import NotesApp

class AllNotesCoordinatorDummy: AllNotesCoordinatorProtocol {
    var didDismiss: Bool = false
    var didNavigateToSettings: Bool = false
    var didNavigateToThemes: Bool = false
    
    func dismiss() {
        didDismiss = true
    }
    
    func navigateToSettings() {
        didNavigateToSettings = true
    }
    
    func navigateToThemes() {
        didNavigateToThemes = true
    }
    
    
}
