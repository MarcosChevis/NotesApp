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
    
    func testNoteAdition() throws {
        try creatNote(withMessage: "oooi")
        
        XCTAssertEqual(1, sut.numberOfElements)
        XCTAssertEqual("oooi", repositoryDelegate.data.first!.note.content)
    }
    
    func testNoteEdit() throws {
        try creatNote(withMessage: "antes de editar")

        let vm = repositoryDelegate.data.first!
        XCTAssertEqual("antes de editar", vm.note.content)
        vm.note.content = "depois de editar"
        try sut.saveChanges()
        coreDataStack.mainContext.rollback()
        let editedNote = repositoryDelegate.data.first!
        XCTAssertEqual("depois de editar", editedNote.note.content)
    }
    
    func testDeleteNote() throws {
        try creatNote(withMessage: "vou deletar")

        let note = repositoryDelegate.data.first!
        XCTAssertEqual("vou deletar", note.note.content)

        try sut.deleteNote(note.note)
        let count = sut.numberOfElements
        XCTAssertEqual(0, count)
    }
    
    func creatNote(withMessage message: String) throws {
        var note = try sut.createEmptyNote()
        note.content = message
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
    
}
