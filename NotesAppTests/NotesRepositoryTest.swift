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
    
    override func setUp() {
        coreDataStack = CoreDataStack(.inMemory)
        sut = NotesRepository(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testNoteAdition() throws {
        try sut.addNote(content: "oooi")
        
        let request = Note.fetchRequest()
        let count = try coreDataStack.mainContext.count(for: request)
        
        XCTAssertEqual(1, count)
    }
    
    func testNoteEdit() throws {
        try sut.addNote(content: "antes de editar")
        
        let request = Note.fetchRequest()
        let note = try coreDataStack.mainContext.fetch(request).first!
        XCTAssertEqual("antes de editar", note.content)
        
        note.content = "depois de editar"
        try sut.editNote(note)
        coreDataStack.mainContext.rollback()
        let editedNote = try coreDataStack.mainContext.fetch(request).first!
        XCTAssertEqual("depois de editar", editedNote.content)
    }
    
    func testDeleteNote() throws {
        try sut.addNote(content: "vou deletar")
        
        let request = Note.fetchRequest()
        
        let note = try coreDataStack.mainContext.fetch(request).first!
        XCTAssertEqual("vou deletar", note.content)
        
        try sut.deleteNote(note)
        let count = try coreDataStack.mainContext.count(for: request)
        XCTAssertEqual(0, count)
    }
    
    
}
