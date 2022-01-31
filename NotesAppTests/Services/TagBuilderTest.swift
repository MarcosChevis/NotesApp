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
        sut = TagBuilder {[weak coreDataStack] in
            guard let coreDataStack = coreDataStack else { return nil }
            return Tag(context: coreDataStack.mainContext)
        }
        
    }
    
    override func tearDown() {
        sut = nil
    }
    
    var changedAndInsertedNotes: [Note] {
        coreDataStack.mainContext.insertedObjects.compactMap { $0 as? Note } + coreDataStack.mainContext.updatedObjects.compactMap { $0 as? Note}
    }
    
    var existingTags: [Tag] {
        try! coreDataStack.mainContext.fetch(Tag.fetchRequest())
    }
    
    var existingNotes: [Note] {
        try! coreDataStack.mainContext.fetch(Note.fetchRequest())
    }
    
    func testCheckTagsCreation() throws {
        
        _ = try createNotes()
        
        let inputedTags = ["#firstTag", "#secondTag", "#thirdTag"]
        
        XCTAssertEqual(2, changedAndInsertedNotes.count)
        XCTAssertEqual(0, existingTags.count)
        
        let tags = sut.buildNewTags(for: changedAndInsertedNotes, existingTags: existingTags)
        
        tags.compactMap(\.name).forEach {
            XCTAssertTrue(inputedTags.contains($0))
        }
        XCTAssertEqual(inputedTags.count, tags.count)
        
        try coreDataStack.save()
        
        XCTAssertEqual([2,2], existingNotes.map(\.allTags.count))
        XCTAssertTrue(coreDataStack.mainContext.insertedObjects.isEmpty)
    }
    
    func testCheckTagsCreationWithExistingTags() throws {
        let notes = try createNotes()
        _ = sut.buildNewTags(for: changedAndInsertedNotes, existingTags: existingTags)
        
        try coreDataStack.save()
        
        let tagCount = try coreDataStack.mainContext.count(for: Tag.fetchRequest())
        let noteCount = try coreDataStack.mainContext.count(for: Note.fetchRequest())
        
        XCTAssertEqual(2, noteCount)
        XCTAssertEqual(3, tagCount)
        XCTAssertEqual([1,1,2], existingTags.compactMap(\.notes).map(\.count).sorted())
        
        notes[0].content?.append(" #fourthTag")
        
        let newTags = sut.buildNewTags(for: changedAndInsertedNotes, existingTags: existingTags)
        
        XCTAssertEqual(1, newTags.count)
        
        try coreDataStack.save()
        
        XCTAssertEqual([2,3], existingNotes.map(\.allTags.count).sorted())
        XCTAssertEqual(4, existingTags.count)
        XCTAssertEqual([1,1,1,2], existingTags.compactMap(\.notes).map(\.count).sorted())
    }
    
    func testCreateNewTagDoesNotRepeatTag() throws {
        _ = try createNotes()
        _ = sut.buildNewTags(for: changedAndInsertedNotes, existingTags: existingTags)
        try coreDataStack.save()
        
        let newNote = Note(context: coreDataStack.mainContext)
        newNote.content = "oi oi tchau #firstTag"
        
        let newTags = sut.buildNewTags(for: changedAndInsertedNotes, existingTags: existingTags)
        
        XCTAssertTrue(newTags.isEmpty)
    }
    
    func testAddExistingTagsIntoNote() throws {
        _ = try createNotes()
        _ = sut.buildNewTags(for: changedAndInsertedNotes, existingTags: existingTags)
        try coreDataStack.save()
        
        let newNote = Note(context: coreDataStack.mainContext)
        newNote.content = "oi oi tchau #firstTag"
        
        let updatedTags = sut.updateExistingTags(existingTags, with: changedAndInsertedNotes)
        
        XCTAssertEqual(1, updatedTags.count)
        XCTAssertEqual("#firstTag", updatedTags.first!.name!)
        
        try coreDataStack.save()
        
        XCTAssertEqual(3, updatedTags.first!.notes!.count)
    }
    
    func createNotes() throws -> [Note] {
        let note1 = Note(context: coreDataStack.mainContext)
        note1.content = "some content #firstTag #secondTag"
        
        let note2 = Note(context: coreDataStack.mainContext)
        note2.content = "some content #firstTag #thirdTag"
        
        return [note1, note2]
    }
}
