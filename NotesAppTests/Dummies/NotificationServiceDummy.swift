//
//  NotificationServiceDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import Foundation
import Combine
@testable import NotesApp
import XCTest

class NotificationServiceDummy: NotificationService {
    var postedNotification: [NSNotification.Name] = []
    var observers: [String] = []
    var removeObservers: [String] = []
    var expectations: [XCTestExpectation] = []
    var notificationSubject: PassthroughSubject<Notification, Never> = .init()
    var postedObjects: [Any?] = []
    
    func post(name: NSNotification.Name, object: Any?) {
        postedNotification.append(name)
        postedObjects.append(object)
    }
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        observers.append(selector.description)
    }
    
    func removeObserver(_ observer: Any) {
        removeObservers.append("Removido")
    }
    
    func publisher(for name: Notification.Name, with object: AnyObject?) -> AnyPublisher<Notification, Never> {
        notificationSubject
            .handleEvents(receiveOutput: {[weak self] _ in self?.expectations.forEach {$0.fulfill()}})
            .eraseToAnyPublisher()
    }
}
