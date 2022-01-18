//
//  NotificationService.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import Foundation
import Combine

protocol NotificationService {
    func post(name: NSNotification.Name, object: Any?)
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?)
    func removeObserver(_ observer: Any)
    func publisher(for name: Notification.Name, with object: AnyObject?) -> AnyPublisher<Notification, Never>
}

extension NotificationCenter: NotificationService {
    func publisher(for name: Notification.Name, with object: AnyObject?) -> AnyPublisher<Notification, Never> {
        publisher(for: name, object: object)
            .eraseToAnyPublisher()
    }
}
