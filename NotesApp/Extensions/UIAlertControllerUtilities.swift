//
//  UIAlertControllerUtilities.swift
//  NotesApp
//
//  Created by Rebecca Mello on 17/01/22.
//

import UIKit

extension UIAlertController {
    struct AlertContent {
        let title: String
        let message: String
        let actionTitle: String
        let actionStyle: UIAlertAction.Style
    }
    
    static func singleActionAlert(with content: AlertContent, _ action: @escaping() -> Void) -> UIAlertController {
        let alert = UIAlertController(title: content.title, message: content.message, preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: content.actionTitle, style: content.actionStyle) { _ in
            action()
        }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        return alert
    }
    
    static func errorAlert(with content: AlertContent) -> UIAlertController {
        let alert = UIAlertController(title: content.title, message: content.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay!", style: .cancel, handler: nil))
        return alert
    }
}
