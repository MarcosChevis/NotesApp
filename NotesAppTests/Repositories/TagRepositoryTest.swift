//
//  TagRepositoryTest.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 02/02/22.
//

import XCTest
@testable import NotesApp

class TagRepositoryTest: XCTestCase {
    
    var sut: TagRepository!
    var delegateDummy: TagRepositoryDelegateDummy!
    var coreDataStack: CoreDataStack!

    override func setUp() {
        coreDataStack = .init(.inMemory)
        sut = .init(coreDataStack: coreDataStack)
        delegateDummy = .init()
        sut.delegate = delegateDummy
        _ = try! sut.getAllTags()
    }
    
    override func tearDown() {
        sut = nil
        delegateDummy = nil
        coreDataStack = nil
    }
    
//    func getAllTags() throws -> [TagCellViewModel] V
//    func insertTag(_ tag: TagCellViewModel)
//    func deleteTag(_ tag: TagCellViewModel)
    
    func testgetAllTags() {
        var count = try! sut.getAllTags().count
        XCTAssertEqual(0, count)
        
        _ = Tag(context: coreDataStack.mainContext)
        try! coreDataStack.save()
        
        count = try! sut.getAllTags().count
        XCTAssertEqual(1, count)
    }
    
    
    func testDelegateInsertTag() {
        _ = Tag(context: coreDataStack.mainContext)
        try! coreDataStack.save()
        
        XCTAssertEqual(1, delegateDummy.data.count)
    }
    
    func testDelegateDeleteTag() {
        let tag = Tag(context: coreDataStack.mainContext)
        try! coreDataStack.save()
        XCTAssertEqual(1, delegateDummy.data.count)
        
        coreDataStack.mainContext.delete(tag)
        try! coreDataStack.save()
        XCTAssertEqual(0, delegateDummy.data.count)
    }
}
