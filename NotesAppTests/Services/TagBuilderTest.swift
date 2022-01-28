//
//  TagBuilderTest.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 25/01/22.
//

import XCTest
@testable import NotesApp

class TagBuilderTest: XCTestCase {

    var sut: TagBuilder!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        coreDataStack = CoreDataStack(.inMemory)
        sut = TagBuilder(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testCheckTagsCreation() {
        let note1 = Note(context: coreDataStack.mainContext)
        note1.content = ""
        
    }
}
