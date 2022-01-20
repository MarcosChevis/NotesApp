//
//  UIAlertControllerUtilities.swift
//  NotesApp
//
//  Created by Rebecca Mello on 17/01/22.
//

import UIKit

extension UIAlertController {
    enum CommonAlert {
        case onDeletingItem
        case unexpectedError(error: String)
    }
    
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
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
    
    static func errorAlert(with content: AlertContent) -> UIAlertController {
        let alert = UIAlertController(title: content.title, message: content.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay!", style: .cancel, handler: nil))
        return alert
    }
    
    static func singleActionAlert(for alertCase: CommonAlert, _ action: @escaping() -> Void) -> UIAlertController {
        singleActionAlert(with: alertCase.content, action)
    }
    
    static func errorAlert(for alertCase: CommonAlert) -> UIAlertController {
        errorAlert(with: alertCase.content)
    }
}

extension UIAlertController.CommonAlert {
    var content: UIAlertController.AlertContent {
        switch self {
        case .onDeletingItem:
            return .init(title: "Are you sure you want to delete it?",
                         message: "This action cannot be undone",
                         actionTitle: "Delete",
                         actionStyle: .destructive)
        case .unexpectedError(let errorMessage):
            return .init(title: "Error!",
                         message: errorMessage,
                         actionTitle: "",
                         actionStyle: .default)
        }
    }
}
