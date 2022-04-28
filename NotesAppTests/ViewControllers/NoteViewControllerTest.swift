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
    var contentView: NoteView!
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
        contentView = .init(palette: .classic)
        sut = NoteViewController(contentView: contentView, palette: .classic, repository: repositoryDummy, notificationService: notificationServiceDummy, settings: settings)
        sut.coordinator = coordinatorDummy
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        repositoryDummy = nil
    }
    
    func testDidAddNote() {
        sut.createNote()
        XCTAssertEqual(1, repositoryDummy.mock.count)
    }
    
    func testDidDeleteNote() {
        sut.createNote()
        XCTAssertEqual(1, repositoryDummy.mock.count)
        
        sut.deleteNote(repositoryDummy.mock.first!.note)
        XCTAssertTrue(coordinatorDummy.didPresentSingleActionAlert.didPresent)
        XCTAssertEqual(0, repositoryDummy.mock.count)
    }
    
    func testDidNavigateToAllNotes() {
        sut.didAllNotes()
        XCTAssertTrue(coordinatorDummy.didNavigateToAllNotes)
    }
    
    func testDidTapShare() {
        sut.createNote()
        var note = repositoryDummy.mock.first!.note
        note.content = "Pudim é melhor que bacon"
        sut.shareNote(note)
        
        XCTAssertTrue(coordinatorDummy.didPresentShareSheet.didPresent)
        XCTAssertEqual(coordinatorDummy.didPresentShareSheet.content, note.content)
    }
    
    
    func testDidTapShareWithAEmptyHighlitedNote() throws {
        sut.createNote()
        sut.shareNote(repositoryDummy.mock.first!.note)
        XCTAssertTrue(coordinatorDummy.didPresentErrorAlert.didPresent)
    }
}
