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
        sut.addNote(content: "oooi")
        
        let request = Note.fetchRequest()
        let count = try coreDataStack.mainContext.count(for: request)
        
        XCTAssertEqual(1, count)
    }
    
    
}
