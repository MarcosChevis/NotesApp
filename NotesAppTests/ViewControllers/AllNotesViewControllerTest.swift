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
    
    func testDidNavigateToSettings() {
        sut.didTapSettings()
        XCTAssertTrue(coordinatorDummy.didNavigateToSettings)
    }
    
    func testDidClose() {
        sut.didTapClose()
        XCTAssertTrue(coordinatorDummy.didDismiss)
    }

    func testDeletenote() {
        let note = NoteCellViewModel(note: NoteDummy(noteID: "id1", content: "conteudo", title: "titulo"))
        noteRepositoryDummy.mock.append(note)
        XCTAssertEqual(1, noteRepositoryDummy.mock.count)
        sut.didTapDelete(for: note)
        XCTAssertEqual(0, noteRepositoryDummy.mock.count)
    }
    
    func testDidTapShare() {
        let content = "teste content"
        sut.didTapShare(for: NoteCellViewModel(note: NoteDummy(noteID: UUID().uuidString, content: content, title: "teste titulo")))
        XCTAssertEqual(coordinatorDummy.sharedNote!, content)
    }
    
    func testDidTapShareWithAEmptyHighlitedNote() throws {
        let content = ""
        sut.didTapShare(for: NoteCellViewModel(note: NoteDummy(noteID: UUID().uuidString, content: content, title: "titulo")))
        XCTAssertNil(coordinatorDummy.sharedNote)
        XCTAssertTrue(coordinatorDummy.didPresentErrorAlert)
    }
}
