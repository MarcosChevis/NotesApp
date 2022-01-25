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
    
    func testViewWithTagsAndNotesOnIphone12neon() {
        let view = setupViewWithTagsAndNotes(with: .neon)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsAndNotesOnIphone12bookish() {
        let view = setupViewWithTagsAndNotes(with: .bookish)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsAndNotesOnIphone12pastel() {
        let view = setupViewWithTagsAndNotes(with: .candy)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsAndNotesOnIphone12christmas() {
        let view = setupViewWithTagsAndNotes(with: .christmas)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func setupViewWithTagsAndNotes(with palette: ColorSet = .classic) -> UIViewController {
        tagRepositoryDummy.mock = [TagCellViewModel(tag: TagDummy(name: "#tag1", tagID: "id1" )), TagCellViewModel(tag: TagDummy(name: "#tag2", tagID: "id2" )), TagCellViewModel(tag: TagDummy(name: "#tag3", tagID: "id3" ))]
        
        noteRepositoryDummy.mock = [NoteCellViewModel(note: NoteDummy(noteID: "id1" , content: "nota1")), NoteCellViewModel(note: NoteDummy(noteID: "id2" , content: "nota2")), NoteCellViewModel(note: NoteDummy(noteID: "id3" , content: "nota3"))]
        sut = .init(palette: palette, noteRepository: noteRepositoryDummy, tagRepository: tagRepositoryDummy)
        
        let navigation = NavigationController(rootViewController: sut)
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
    
    func testViewWithTagsOnlyOnIphone12neon() {
        let view = setupViewWithTagsOnly(with: .neon)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsOnlyOnIphone12pastel() {
        let view = setupViewWithTagsOnly(with: .candy)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsOnlyOnIphone12bookish() {
        let view = setupViewWithTagsOnly(with: .bookish)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsOnlyOnIphone12christmas() {
        let view = setupViewWithTagsOnly(with: .christmas)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func setupViewWithTagsOnly(with palette: ColorSet = .classic) -> UIViewController {
        tagRepositoryDummy.mock = [TagCellViewModel(tag: TagDummy(name: "#tag1", tagID: "id1" )), TagCellViewModel(tag: TagDummy(name: "#tag2", tagID: "id2" )), TagCellViewModel(tag: TagDummy(name: "#tag3", tagID: "id3" ))]
        sut = .init(palette: palette, noteRepository: noteRepositoryDummy, tagRepository: tagRepositoryDummy)
        
        let navigation = NavigationController(rootViewController: sut)
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
    
    func testViewWithNotesOnlyOnIphone12neon() {
        let view = setupViewWithNotesOnly(with: .neon)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNotesOnlyOnIphone12pastel() {
        let view = setupViewWithNotesOnly(with: .candy)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNotesOnlyOnIphone12bookish() {
        let view = setupViewWithNotesOnly(with: .bookish)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNotesOnlyOnIphone12christmas() {
        let view = setupViewWithNotesOnly(with: .christmas)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func setupViewWithNotesOnly(with palette: ColorSet = .classic) -> UIViewController {
        noteRepositoryDummy.mock = [NoteCellViewModel(note: NoteDummy(noteID: "id1" , content: "nota1")), NoteCellViewModel(note: NoteDummy(noteID: "id2" , content: "nota2")), NoteCellViewModel(note: NoteDummy(noteID: "id3" , content: "nota3"))]
        sut = .init(palette: palette, noteRepository: noteRepositoryDummy, tagRepository: tagRepositoryDummy)
        
        let navigation = NavigationController(rootViewController: sut)
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
    
    func testViewWithNoTagsAndNotesOnIphone12neon() {
        let view = setupWithNoTagsAndNotes(with: .neon)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNoTagsAndNotesOnIphone12pastel() {
        let view = setupWithNoTagsAndNotes(with: .candy)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNoTagsAndNotesOnIphone12christmas() {
        let view = setupWithNoTagsAndNotes(with: .christmas)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNoTagsAndNotesOnIphone12bookish() {
        let view = setupWithNoTagsAndNotes(with: .bookish)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func setupWithNoTagsAndNotes(with palette: ColorSet = .classic) -> UIViewController {
        sut = .init(palette: palette, noteRepository: noteRepositoryDummy, tagRepository: tagRepositoryDummy)
        let navigation = NavigationController(rootViewController: sut)
        return navigation
    }
    
}
