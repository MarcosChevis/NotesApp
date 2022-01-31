//
//  ShareCoordinatorProtocol.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 26/01/22.
//

import UIKit

protocol NoteShareCoordinatorProtocol {
    func shareContent(_ content: String)
}

extension NoteShareCoordinatorProtocol where Self : CoordinatorProtocol {
    func shareContent(_ content: String) {
        let shareScreen = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        navigationController.present(shareScreen, animated: true, completion: nil)
    }
}
