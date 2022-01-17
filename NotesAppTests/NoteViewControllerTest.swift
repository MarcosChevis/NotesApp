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
    var notificationServiceDummy: NotificationServiceDummy!
    var sut: NoteViewController!

    override func setUp() {
        repositoryDummy = .init()
        notificationServiceDummy = .init()
        sut = .init(palette: .classic, repository: repositoryDummy, notificationService: notificationServiceDummy)
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        repositoryDummy = nil
        notificationServiceDummy = nil
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
    
    func testDidSaveOnUIExit() {
        XCTAssertEqual(notificationServiceDummy.observers, ["appIsEnteringInBackground"])
    }
    
    func testSavingMethodCall() {
        sut = .init(palette: .classic, repository: repositoryDummy, notificationService: NotificationCenter.default)
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        XCTAssertEqual(repositoryDummy.didCallSaveChanges, true)
    }
}
