//
//  ShareCoordinatorProtocol.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 26/01/22.
//

import UIKit

protocol NoteShareCoordinatorProtocol {
    func shareNote(_ note: NoteProtocol)
}

extension NoteShareCoordinatorProtocol where Self : CoordinatorProtocol, Self : AlertCoordinatorProtocol {
    func shareNote(_ note: NoteProtocol) {
        guard let content = note.content, !content.isEmpty else {
            presentErrorAlert(with: "Your note is empty")
            return
        }
        
        let shareScreen = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        navigationController.present(shareScreen, animated: true, completion: nil)
    }
}
