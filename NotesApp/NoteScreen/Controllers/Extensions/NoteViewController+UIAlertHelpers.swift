//
//  NoteViewController+UIAlertHelpers.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension NoteViewController {
    func presentAlert(for alertCase: UIAlertController.CommonAlert, _ action: @escaping() -> Void) {
        let alert = UIAlertController.singleActionAlert(for: alertCase) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            action()
        }
        self.present(alert, animated: true)
    }
    
    func presentErrorAlert(with errorMessage: String) {
        let alert = UIAlertController.errorAlert(for: .unexpectedError(error: errorMessage))
        self.present(alert, animated: true)
    }
}
