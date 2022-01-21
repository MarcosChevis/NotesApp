//
//  AllNotesViewControllerTest.swift
//  NotesAppTests
//
//  Created by Rebecca Mello on 21/01/22.
//

import XCTest
@testable import NotesApp

class AllNotesViewControllerTest: XCTestCase {

    var tagRepositoryDummy: TagRepositoryDummy!
    var noteRepositoryDummy: NoteRepositoryDummy!
    var sut: AllNotesViewController!
    var coordinatorDummy: AllNotesCoordinatorDummy!
    var settings: Settings!
    var localStorageServiceDummy: LocalStorageServiceDummy!
    var notificationServiceDummy: NotificationServiceDummy!

    override func setUp() {
        coordinatorDummy = .init()
        localStorageServiceDummy = .init()
        notificationServiceDummy = .init()
        tagRepositoryDummy = .init()
        noteRepositoryDummy = .init()
        settings = .init(localStorageService: localStorageServiceDummy, notificationService: notificationServiceDummy)
        sut = AllNotesViewController(palette: .classic, noteRepository: noteRepositoryDummy, tagRepository: tagRepositoryDummy, notificationService: notificationServiceDummy, settings: settings)
        sut.coordinator = coordinatorDummy
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        tagRepositoryDummy = nil
        noteRepositoryDummy = nil
    }
    
    func testDidAddNote() {
        sut.didTapAddNote()
        XCTAssertEqual(1, noteRepositoryDummy.mock.count)
    }
    
    func testDidNavigateToSettings() {
        sut.didTapSettings()
        XCTAssertTrue(coordinatorDummy.didNavigateToSettings)
    }
    
    func testDidClose() {
        sut.didTapClose()
        XCTAssertTrue(coordinatorDummy.didDismiss)
    }

}
