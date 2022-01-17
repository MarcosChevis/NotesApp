//
//  NotificationService.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import Foundation

protocol NotificationService {
    func post(name: NSNotification.Name, object: Any?)
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?)
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: NotificationService {}
