//
//  NoteViewControllerTest.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import XCTest
@testable import NotesApp

class NoteViewControllerTest: XCTestCase {
    
    var repositoryDummy: NoteRepositoryDummy!
    var sut: NoteViewController!
    var coordinatorDummy: MainCoordinatorDummy!
    var settings: Settings!
    var localStorageServiceDummy: LocalStorageServiceDummy!
    var notificationServiceDummy: NotificationServiceDummy!

    override func setUp() {
        repositoryDummy = .init()
        coordinatorDummy = .init()
        localStorageServiceDummy = .init()
        notificationServiceDummy = .init()
        settings = .init(localStorageService: localStorageServiceDummy, notificationService: notificationServiceDummy)
        sut = NoteViewController(palette: .classic, repository: repositoryDummy, notificationService: notificationServiceDummy, settings: settings)
        sut.coordinator = coordinatorDummy
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        repositoryDummy = nil
    }
    
    func testDidAddNote() {
        sut.didAdd()
        XCTAssertEqual(1, repositoryDummy.mock.count)
    }
    
    func testDidDeleteNote() {
        sut.didAdd()
        sut.collectionViewDidMove(to: IndexPath(row: 0, section: 0))
        sut.deleteNote()
        XCTAssertEqual(0, repositoryDummy.mock.count)
    }
    
    func testDidNavigateToAllNotes() {
        sut.didAllNotes()
        XCTAssertTrue(coordinatorDummy.didNavigateToAllNotes)
    }
    
    
}
