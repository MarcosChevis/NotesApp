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
    
    override func setUp() {
        sut = TagBuilder(coreDataStack: CoreDataStack(.inMemory))
    }

    override func tearDown() {
        sut = nil
    }
    
    func testCheckTagsCreation() {
        let content = "some notes #swiftie #pudim #melhorQueBacon"
        let tags = sut.findTagContent(for: content)
        
        XCTAssertEqual(tags, ["#swiftie", "#pudim", "#melhorQueBacon"])
    }
}
