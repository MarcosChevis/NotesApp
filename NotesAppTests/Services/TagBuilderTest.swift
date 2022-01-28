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
    
    func testCheckTagsCreation() throws {
        
        let notes = try createNotes()
        
        let inputedTags = ["#firstTag", "#secondTag", "#thirdTag"]
        let tags = sut.build(for: notes)
        
        tags.compactMap(\.name).forEach {
            XCTAssertTrue(inputedTags.contains($0))
        }
        XCTAssertEqual(inputedTags.count, tags.count)
        
        
    }
    
    func testCheckTagsCreationWithExistingTags() throws {
        let notes = try createNotes()
        let tags = sut.build(for: notes)
        let tagsEntities = tags as! [Tag]
        try coreDataStack.save()
        
        let request = Tag.fetchRequest()
        let savedTags = try coreDataStack.mainContext.fetch(request)
        
        XCTAssertEqual(savedTags.count, tags.count)
        
        let noteCounts = tagsEntities.compactMap(\.notes).map(\.count).sorted()
         
        XCTAssertEqual([1, 1, 2], noteCounts)
        XCTAssertEqual([2,2], notes.map(\.allTags.count).sorted())
        
        notes[0].content?.append(" #fourthTag")
        try coreDataStack.save()
        
        let newTags = sut.build(for: notes)
        XCTAssertEqual(1, newTags.count)
        XCTAssertEqual("#fourthTag", newTags.first!.name)
        
        try coreDataStack.save()
        
        let updatedNotes = try coreDataStack.mainContext.fetch(Note.fetchRequest())
        let updatedTags = try coreDataStack.mainContext.fetch(Tag.fetchRequest())
        
        XCTAssertEqual(updatedTags.count, 4)
        XCTAssertEqual([1, 1, 1, 2], updatedTags.compactMap(\.notes).map(\.count).sorted())
        XCTAssertEqual([2,3], updatedNotes.map(\.allTags.count).sorted())
    }
    
    func createNotes() throws -> [Note] {
        let note1 = Note(context: coreDataStack.mainContext)
        note1.content = "some content #firstTag #secondTag"
        
        let note2 = Note(context: coreDataStack.mainContext)
        note2.content = "some content #firstTag #thirdTag"
        
        try coreDataStack.save()
        return [note1, note2]
    }
}
