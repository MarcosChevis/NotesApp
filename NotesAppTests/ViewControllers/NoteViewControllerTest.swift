//
//  NoteViewControllerTest.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import XCTest
@testable import NotesApp

class NoteViewControllerTest: XCTestCase {
    
    var repositoryDummy: NoteRepositoryDummy!
    var sut: NoteViewController!

    override func setUp() {
        repositoryDummy = .init()
        sut = .init(palette: .classic, repository: repositoryDummy)
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        repositoryDummy = nil
    }
    
    func testDidAddNote() {
        sut.didAdd()
        XCTAssertEqual(1, repositoryDummy.mock.count)
    }
    
    func testDidDeleteNote() {
        sut.didAdd()
        sut.collectionViewDidMove(to: IndexPath(row: 0, section: 0))
        sut.deleteNote()
        XCTAssertEqual(0, repositoryDummy.mock.count)
    }
    
    
}
