//
//  UIActivityViewController+NoteCellViewModel.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 19/01/22.
//

import UIKit

extension UIActivityViewController {
    static func shareNote(_ note: NoteProtocol) throws -> UIActivityViewController {
        guard let content = note.content, !content.isEmpty else {
            throw NSError(domain: "Empty Note", code: 0, userInfo: nil)
        }
        
        let activityViewController = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        return activityViewController
    }
}
