//
//  NotesRepositoryTest.swift
//  NotesAppTests
//
//  Created by Rebecca Mello on 12/01/22.
//

import XCTest
import Combine
@testable import NotesApp

class NotesRepositoryTest: XCTestCase {
    
    var sut: NotesRepository!
    var coreDataStack: CoreDataStack!
    var repositoryDelegate: NoteRepositoryDelegateDummy!
    var notificationDummy: NotificationServiceDummy!
    var cancelables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        coreDataStack = CoreDataStack(.inMemory)
        notificationDummy = .init()
        repositoryDelegate = .init()
        cancelables = .init()
        sut = NotesRepository(coreDataStack: coreDataStack, notificationService: notificationDummy)
        sut.delegate = repositoryDelegate
        try sut.fetchResultsController.performFetch()
    }
    
    override func tearDown() {
        sut = nil
        coreDataStack = nil
        repositoryDelegate = nil
        notificationDummy = nil
        cancelables.forEach { $0.cancel() }
        cancelables = nil
    }
    
    func testNoteCreation() throws {
        try createNote(withMessage: "Uma nova nota")
        try sut.saveChanges()

        XCTAssertEqual(repositoryDelegate.data.count, 1)
        XCTAssertEqual(repositoryDelegate.data.first!.note.content, "Uma nova nota")
    }
    
    func testNoteEdit() throws {
        try createNote(withMessage: "antes de editar")

        let vm = repositoryDelegate.data.first!
        XCTAssertEqual("antes de editar", vm.note.content)
        vm.note.content = "depois de editar"
        try sut.saveChanges()
        coreDataStack.mainContext.rollback()
        let editedNote = repositoryDelegate.data.first!
        XCTAssertEqual("depois de editar", editedNote.note.content)
    }
    
    func testDeleteNote() throws {
        try createNote(withMessage: "vou deletar")

        let note = repositoryDelegate.data.first!
        XCTAssertEqual("vou deletar", note.note.content)

        try sut.deleteNote(note.note)
        let count = repositoryDelegate.data.count
        XCTAssertEqual(0, count)
    }
    
    func createNote(withMessage message: String, title: String = "title") throws {
        var note = try sut.createEmptyNote()
        note.content = message
        note.title = title
    }
    
    func testAppEnterBackground() throws {
        _ = try sut.createEmptyNote()
        _ = try sut.createEmptyNote()
        _ = try sut.createEmptyNote()
        
        XCTAssertEqual(repositoryDelegate.data.count, 3)
        let expectation = XCTestExpectation(description: "Expect Notification Call")
        
        notificationDummy.expectations.append(expectation)
        
        notificationDummy.notificationSubject.send(Notification.init(name: UIApplication.willResignActiveNotification, object: nil, userInfo: nil))
        
        wait(for: notificationDummy.expectations, timeout: 3)
        XCTAssertEqual(repositoryDelegate.data.count, 0)
    }
    
    func testFilteredNotesWithEmptyContent() throws {
        try createNote(withMessage: "miau")
        try createNote(withMessage: "Outra nota")
        try createNote(withMessage: "Outra mais uma nota")
        let filteredNotes = sut.filterForContent("")
        
        XCTAssertEqual(filteredNotes.count, 3)
    }
    
    func testFilterNoteWithContent() throws {
        try createNote(withMessage: "miau")
        try createNote(withMessage: "Outra NOTA")
        try createNote(withMessage: "Outra mais uma nota")
        let filteredNotes = sut.filterForContent("nota")
        
        XCTAssertEqual(filteredNotes.count, 2)
    }
    
    func testFilterNoteWithContentWhenResultZero() throws {
        try createNote(withMessage: "miau")
        try createNote(withMessage: "Outra nota")
        try createNote(withMessage: "Outra mais uma nota")
        let filteredNotes = sut.filterForContent("toti")
        
        XCTAssertEqual(filteredNotes.count, 0)
    }
    
    func testFilterNoteWithContentAndTitle() throws {
        try createNote(withMessage: "miau")
        try createNote(withMessage: "Outra nota", title: "miau")
        try createNote(withMessage: "Outra mais uma nota")
        let filteredNotes = sut.filterForContent("miau")
        
        XCTAssertEqual(filteredNotes.count, 2)
    }
    
}
