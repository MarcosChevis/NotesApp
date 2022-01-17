//
//  NotificationServiceDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import Foundation
@testable import NotesApp

class NotificationServiceDummy: NotificationService {
    var postedNotification: [NSNotification.Name] = []
    var observers: [String] = []
    var removeObservers: [String] = []
    
    func post(name: NSNotification.Name, object: Any?) {
        postedNotification.append(name)
    }
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        observers.append(selector.description)
    }
    
    func removeObserver(_ observer: Any) {
        removeObservers.append("Removido")
    }
}
