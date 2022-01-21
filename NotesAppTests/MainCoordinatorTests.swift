//
//  MainCoordinatorTests.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import XCTest
@testable import NotesApp

class MainCoordinatorTest: XCTestCase {

    var sut: MainCoordinator!
    var settings: Settings!
    var notificationService: NotificationCenter!
    var localStorageService: LocalStorageServiceDummy!
    
    override func setUp() {
        notificationService = .init()
        localStorageService = .init()
        settings = .init(localStorageService: localStorageService, notificationService: notificationService)
        sut = .init(navigationController: NavigationController(), settings: settings, notificationService: notificationService)
        sut.start()
    }
    
    override func tearDown() {
        sut = nil
        settings = nil
        notificationService = nil
        localStorageService = nil
        sut = nil
    }
    
    func testAddedChildCoordinator() {
        sut.navigateToAllNotes()
        XCTAssertEqual(1, sut.childCoordinators.count)
    }
    
    func testRemoval() {
        sut.navigateToAllNotes()
        notificationService.post(name: .didComebackFromModal, object: nil)
        XCTAssertEqual(0, sut.childCoordinators.count)
    }
}
