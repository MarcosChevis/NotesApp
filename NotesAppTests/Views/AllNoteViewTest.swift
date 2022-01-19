//
//  AllNoteViewTest.swift
//  NotesAppTests
//
//  Created by Rebecca Mello on 19/01/22.
//

import XCTest
@testable import NotesApp
import SnapshotTesting

class AllNoteViewTest: XCTestCase {

    var sut: AllNotesViewController!
    var tagRepositoryDummy: TagRepositoryDummy!
    var noteRepositoryDummy: NoteRepositoryDummy!
    
    override func setUp() {
        tagRepositoryDummy = .init()
        noteRepositoryDummy = .init()
        sut = .init(palette: .classic, noteRepository: noteRepositoryDummy, tagRepository: tagRepositoryDummy)
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
        tagRepositoryDummy = nil
        noteRepositoryDummy = nil
    }
    
    // Teste com Tags e Notas
    func testViewWithTagsAndNotesOnIphone12() {
        let view = setupViewWithTagsAndNotes()
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsAndNotesOnIphoneSE() {
        let view = setupViewWithTagsAndNotes()
        assertSnapshot(matching: view, as: .image(on: .iPhoneSe))
    }
    
    func testViewWithTagsAndNotesOnIphone12ProMax() {
        let view = setupViewWithTagsAndNotes()
        assertSnapshot(matching: view, as: .image(on: .iPhone12ProMax))
    }
    
    func setupViewWithTagsAndNotes() -> UIViewController {
        tagRepositoryDummy.mock = [TagCellViewModel(tag: TagDummy(name: "#tag1", tagID: "id1" )), TagCellViewModel(tag: TagDummy(name: "#tag2", tagID: "id2" )), TagCellViewModel(tag: TagDummy(name: "#tag3", tagID: "id3" ))]
        
        noteRepositoryDummy.mock = [NoteCellViewModel(note: NoteDummy(noteID: "id1" , content: "nota1")), NoteCellViewModel(note: NoteDummy(noteID: "id2" , content: "nota2")), NoteCellViewModel(note: NoteDummy(noteID: "id3" , content: "nota3"))]
        
        let navigation = UINavigationController(rootViewController: sut)
        return navigation
        
    }
    
    // Teste com apenas Tags
    func testViewWithTagsOnlyOnIphone12() {
        let view = setupViewWithTagsOnly()
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsOnlyOnIphoneSE() {
        let view = setupViewWithTagsOnly()
        assertSnapshot(matching: view, as: .image(on: .iPhoneSe))
    }
    
    func testViewWithTagsOnlyOnIphone12ProMax() {
        let view = setupViewWithTagsOnly()
        assertSnapshot(matching: view, as: .image(on: .iPhone12ProMax))
    }
    
    func setupViewWithTagsOnly() -> UIViewController {
        tagRepositoryDummy.mock = [TagCellViewModel(tag: TagDummy(name: "#tag1", tagID: "id1" )), TagCellViewModel(tag: TagDummy(name: "#tag2", tagID: "id2" )), TagCellViewModel(tag: TagDummy(name: "#tag3", tagID: "id3" ))]
        
        let navigation = UINavigationController(rootViewController: sut)
        return navigation
    }
    
    // Teste com apenas Notas
    func testViewWithNotesOnlyOnIphone12() {
        let view = setupViewWithNotesOnly()
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNotesOnlyOnIphoneSE() {
        let view = setupViewWithNotesOnly()
        assertSnapshot(matching: view, as: .image(on: .iPhoneSe))
    }
    
    func testViewWithNotesOnlyOnIphone12ProMax() {
        let view = setupViewWithNotesOnly()
        assertSnapshot(matching: view, as: .image(on: .iPhone12ProMax))
    }
    
    func setupViewWithNotesOnly() -> UIViewController {
        noteRepositoryDummy.mock = [NoteCellViewModel(note: NoteDummy(noteID: "id1" , content: "nota1")), NoteCellViewModel(note: NoteDummy(noteID: "id2" , content: "nota2")), NoteCellViewModel(note: NoteDummy(noteID: "id3" , content: "nota3"))]
        
        let navigation = UINavigationController(rootViewController: sut)
        return navigation
    }
    
    // Teste sem nada na tela
    func testViewWithNoTagsAndNotesOnIphone12() {
        let view = setupWithNoTagsAndNotes()
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNoTagsAndNotesOnIphoneSE() {
        let view = setupWithNoTagsAndNotes()
        assertSnapshot(matching: view, as: .image(on: .iPhoneSe))
    }
    
    func testViewWithNoTagsAndNotesOnIphone12ProMax() {
        let view = setupWithNoTagsAndNotes()
        assertSnapshot(matching: view, as: .image(on: .iPhone12ProMax))
    }
    
    func setupWithNoTagsAndNotes() -> UIViewController {
        let navigation = UINavigationController(rootViewController: sut)
        return navigation
    }
    
}
