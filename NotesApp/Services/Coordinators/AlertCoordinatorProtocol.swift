//
//  AlertCoordinator.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 26/01/22.
//

import UIKit

protocol AlertCoordinatorProtocol {
    func presentSingleActionAlert(for alertCase: UIAlertController.CommonAlert, _ action: @escaping() -> Void)
    func presentErrorAlert(with message: String)
}

extension AlertCoordinatorProtocol where Self : CoordinatorProtocol {
    func presentSingleActionAlert(for alertCase: UIAlertController.CommonAlert, _ action: @escaping() -> Void) {
        navigationController.presentAlert(for: alertCase, action)
    }
    
    func presentErrorAlert(with message: String) {
        navigationController.presentErrorAlert(with: message)
    }
}
