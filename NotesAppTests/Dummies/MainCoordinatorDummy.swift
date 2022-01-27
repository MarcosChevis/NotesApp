//
//  MainCoordinatorDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit
@testable import NotesApp

class MainCoordinatorDummy: MainCoordinatorProtocol {
    var didNavigateToAllNotes: Bool = false
    var didPresentSingleActionAlert: PresentModalContent = .init()
    var didPresentErrorAlert: PresentModalContent = .init()
    var didPresentShareSheet: PresentModalContent = .init()
    
    func navigateToAllNotes() {
        didNavigateToAllNotes = true
    }
    
    func presentSingleActionAlert(for alertCase: UIAlertController.CommonAlert, _ action: @escaping () -> Void) {
        didPresentSingleActionAlert.didPresent = true
        didPresentSingleActionAlert.content = alertCase.content.message
        action()
    }
    
    func presentErrorAlert(with message: String) {
        didPresentErrorAlert.didPresent = true
        didPresentErrorAlert.content = message
    }
    
    func shareNote(_ note: NoteProtocol) {
        didPresentShareSheet.didPresent = true
        didPresentShareSheet.content = note.content!
    }
}

struct PresentModalContent {
    var didPresent: Bool = false
    var content: String = ""
}
