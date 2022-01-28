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
    var themeRepository: ThemeRepositoryProtocol!
    
    override func setUp() {
        tagRepositoryDummy = .init()
        noteRepositoryDummy = .init()
        themeRepository = ThemeRepository(coreDataStack: .init(.inMemory))
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
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "224462ed-d295-4ba7-a9bd-9b986ba751df") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithTagsAndNotesOnIphone12bookish() {
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "bc09ce57-6039-445f-83e4-c7165b4afc79") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithTagsAndNotesOnIphone12grape() {
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "6bcb4b2d-6afa-4a2a-b4dc-f2cca83a44c7") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithTagsAndNotesOnIphone12christmas() {
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "a1c6b360-2b91-473c-b24e-8a95d3ed45d9") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsAndNotesOnIphone12dark() {
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "50fab20d-3934-4a4a-8274-1ad502544a06") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsAndNotesOnIphone12halloween() {
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "bf2ae775-8660-4e33-88d3-0676bdf47572") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsAndNotesOnIphone12devotional() {
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "0765f920-170e-4521-b077-cd496917f21b") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithTagsAndNotesOnIphone12matrix() {
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "f5e3ec97-1b02-46f2-b2de-0592d7fe48b5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsAndNotesOnIphone12unicorn() {
        let view = setupViewWithTagsAndNotes(with: themeRepository.getTheme(with: "8de332a6-2120-45b8-b638-f2c86b017aa5") ?? .classic)
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
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "224462ed-d295-4ba7-a9bd-9b986ba751df") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithTagsOnlyOnIphone12bookish() {
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "bc09ce57-6039-445f-83e4-c7165b4afc79") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithTagsOnlyOnIphone12grape() {
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "6bcb4b2d-6afa-4a2a-b4dc-f2cca83a44c7") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithTagsOnlyOnIphone12christmas() {
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "a1c6b360-2b91-473c-b24e-8a95d3ed45d9") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsOnlyOnIphone12dark() {
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "50fab20d-3934-4a4a-8274-1ad502544a06") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsOnlyOnIphone12halloween() {
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "bf2ae775-8660-4e33-88d3-0676bdf47572") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsOnlyOnIphone12devotional() {
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "0765f920-170e-4521-b077-cd496917f21b") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithTagsOnlyOnIphone12matrix() {
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "f5e3ec97-1b02-46f2-b2de-0592d7fe48b5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithTagsOnlyOnIphone12unicorn() {
        let view = setupViewWithTagsOnly(with: themeRepository.getTheme(with: "8de332a6-2120-45b8-b638-f2c86b017aa5") ?? .classic)
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
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "224462ed-d295-4ba7-a9bd-9b986ba751df") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithNotesOnlyOnIphone12bookish() {
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "bc09ce57-6039-445f-83e4-c7165b4afc79") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithNotesOnlyOnIphone12grape() {
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "6bcb4b2d-6afa-4a2a-b4dc-f2cca83a44c7") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithNotesOnlyOnIphone12christmas() {
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "a1c6b360-2b91-473c-b24e-8a95d3ed45d9") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNotesOnlyOnIphone12dark() {
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "50fab20d-3934-4a4a-8274-1ad502544a06") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNotesOnlyOnIphone12halloween() {
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "bf2ae775-8660-4e33-88d3-0676bdf47572") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNotesOnlyOnIphone12devotional() {
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "0765f920-170e-4521-b077-cd496917f21b") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithNotesOnlyOnIphone12matrix() {
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "f5e3ec97-1b02-46f2-b2de-0592d7fe48b5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNotesOnlyOnIphone12unicorn() {
        let view = setupViewWithNotesOnly(with: themeRepository.getTheme(with: "8de332a6-2120-45b8-b638-f2c86b017aa5") ?? .classic)
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
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "224462ed-d295-4ba7-a9bd-9b986ba751df") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithNoTagsAndNotesOnIphone12bookish() {
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "bc09ce57-6039-445f-83e4-c7165b4afc79") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithNoTagsAndNotesOnIphone12grape() {
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "6bcb4b2d-6afa-4a2a-b4dc-f2cca83a44c7") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithNoTagsAndNotesOnIphone12christmas() {
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "a1c6b360-2b91-473c-b24e-8a95d3ed45d9") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNoTagsAndNotesOnIphone12dark() {
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "50fab20d-3934-4a4a-8274-1ad502544a06") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNoTagsAndNotesOnIphone12halloween() {
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "bf2ae775-8660-4e33-88d3-0676bdf47572") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNoTagsAndNotesOnIphone12devotional() {
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "0765f920-170e-4521-b077-cd496917f21b") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testViewWithNoTagsAndNotesOnIphone12matrix() {
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "f5e3ec97-1b02-46f2-b2de-0592d7fe48b5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testViewWithNoTagsAndNotesOnIphone12unicorn() {
        let view = setupWithNoTagsAndNotes(with: themeRepository.getTheme(with: "8de332a6-2120-45b8-b638-f2c86b017aa5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func setupWithNoTagsAndNotes(with palette: ColorSet = .classic) -> UIViewController {
        sut = .init(palette: palette, noteRepository: noteRepositoryDummy, tagRepository: tagRepositoryDummy)
        let navigation = NavigationController(rootViewController: sut)
        return navigation
    }
    
}
