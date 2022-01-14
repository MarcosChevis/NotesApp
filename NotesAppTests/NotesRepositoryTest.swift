//
//  NotesRepositoryTest.swift
//  NotesAppTests
//
//  Created by Rebecca Mello on 12/01/22.
//

import XCTest
@testable import NotesApp

class NotesRepositoryTest: XCTestCase {
    
    var sut: NotesRepository!
    var coreDataStack: CoreDataStack!
    var frcDelegateDummy: FetchResultsControllerDelegateDummy<Note>!
    
    override func setUpWithError() throws {
        coreDataStack = CoreDataStack(.inMemory)
        sut = NotesRepository(coreDataStack: coreDataStack)
        frcDelegateDummy = .init()
        sut.fetchResultsController.delegate = frcDelegateDummy
        try sut.fetchResultsController.performFetch()
    }
    
    override func tearDown() {
        sut = nil
        coreDataStack = nil
        frcDelegateDummy = nil
    }
    
    func testNoteAdition() throws {
        try creatNote(withMessage: "oooi")
        
        XCTAssertEqual(1, sut.numberOfElements)
        XCTAssertEqual("oooi", frcDelegateDummy.data.first!.content)
    }
    
    func testNoteEdit() throws {
        try creatNote(withMessage: "antes de editar")

        let note = frcDelegateDummy.data.first!
        XCTAssertEqual("antes de editar", note.content)
        note.content = "depois de editar"
        try sut.saveChanges()
        coreDataStack.mainContext.rollback()
        let editedNote = frcDelegateDummy.data.first!
        XCTAssertEqual("depois de editar", editedNote.content)
    }
    
    func testDeleteNote() throws {
        try creatNote(withMessage: "vou deletar")

        let note = frcDelegateDummy.data.first!
        XCTAssertEqual("vou deletar", note.content)

        try sut.deleteNote(note)
        let count = sut.numberOfElements
        XCTAssertEqual(0, count)
    }
    
    func creatNote(withMessage message: String) throws {
        var note = try sut.createEmptyNote()
        note.content = message
    }
    
}
