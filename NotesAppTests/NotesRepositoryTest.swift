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
        try sut.addNote(content: "oooi")
        
        XCTAssertEqual(1, sut.numberOfElements)
        XCTAssertEqual("oooi", frcDelegateDummy.data.first!.content)
    }
    
    func testNoteEdit() throws {
        try sut.addNote(content: "antes de editar")
        
        let note = frcDelegateDummy.data.first!
        XCTAssertEqual("antes de editar", note.content)
        
        try sut.editNote(with: NoteCellViewModel(id: note.objectID.uriRepresentation(), title: "", content: "depois de editar"))
        
        coreDataStack.mainContext.rollback()
        let editedNote = frcDelegateDummy.data.first!
        XCTAssertEqual("depois de editar", editedNote.content)
    }
    
    func testDeleteNote() throws {
        try sut.addNote(content: "vou deletar")
        
        let note = frcDelegateDummy.data.first!
        XCTAssertEqual("vou deletar", note.content)
        
        try sut.deleteNote(note.objectID.uriRepresentation())
        let count = sut.numberOfElements
        XCTAssertEqual(0, count)
    }
    
    func testElementCount() throws {
        XCTAssertEqual(0, sut.numberOfElements)
        
        try sut.addNote(content: "Teste contagem")
        
        XCTAssertEqual(1, sut.numberOfElements)
    }
}
