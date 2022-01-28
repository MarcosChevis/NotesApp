//
//  NoteViewTest.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 18/01/22.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import NotesApp

class NoteViewTest: XCTestCase {
    
    var sut: NoteViewController!
    var repositoryDummy: NoteRepositoryDummy!
    var colorSet: ColorSet!
    var themeRepository: ThemeRepositoryProtocol!
    
    override func setUp() {
        #warning("mudar implementacao")
        
        repositoryDummy = .init()
        themeRepository = ThemeRepository(coreDataStack: .init(.inMemory))
        sut = .init(palette: .classic, repository: repositoryDummy)
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
        repositoryDummy = nil
        colorSet = nil
    }
    
    #warning("reimplementar testes")
    func testLayoutWithMoreThanOneItemOnIphone12() {
        let view = setupLayoutTestWithMoreThanItem(with: .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }


    func testLayoutWithMoreThanOneItemOnIphoneSE() {
        let view = setupLayoutTestWithMoreThanItem(with: .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhoneSe))
    }

    func testLayoutWithMoreThanOneItemOnIphone12ProMax() {
        let view = setupLayoutTestWithMoreThanItem(with: .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12ProMax))
    }

    func testLayoutWithNoItemsOnIphone12() {
        let navigation = NavigationController(rootViewController: sut)
        assertSnapshot(matching: navigation, as: .image(on: .iPhone12))
    }

    func testLayoutWithNoItemsOnIphoneSE() {
        let navigation = NavigationController(rootViewController: sut)
        assertSnapshot(matching: navigation, as: .image(on: .iPhoneSe))
    }

    func testLayoutWithNoItemsOnIphone12ProMax() {
        let navigation = NavigationController(rootViewController: sut)
        assertSnapshot(matching: navigation, as: .image(on: .iPhone12ProMax))
    }

    func testLayoutWithMoreThanOneItemOnIphone12neon() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "224462ed-d295-4ba7-a9bd-9b986ba751df") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testLayoutWithMoreThanOneItemOnIphone12bookish() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "bc09ce57-6039-445f-83e4-c7165b4afc79") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testLayoutWithMoreThanOneItemOnIphone12grape() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "6bcb4b2d-6afa-4a2a-b4dc-f2cca83a44c7") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testLayoutWithMoreThanOneItemOnIphone12christmas() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "a1c6b360-2b91-473c-b24e-8a95d3ed45d9") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutWithMoreThanOneItemOnIphone12dark() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "50fab20d-3934-4a4a-8274-1ad502544a06") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutWithMoreThanOneItemOnIphone12halloween() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "bf2ae775-8660-4e33-88d3-0676bdf47572") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutWithMoreThanOneItemOnIphone12devotional() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "0765f920-170e-4521-b077-cd496917f21b") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testLayoutWithMoreThanOneItemOnIphone12matrix() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "f5e3ec97-1b02-46f2-b2de-0592d7fe48b5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutWithMoreThanOneItemOnIphone12unicorn() {
        let view = setupLayoutTestWithMoreThanItem(with: themeRepository.getTheme(with: "8de332a6-2120-45b8-b638-f2c86b017aa5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    
    func setupLayoutTestWithMoreThanItem(with palette: ColorSet) -> UIViewController {
        repositoryDummy.mock = [NoteCellViewModel.init(note: NoteDummy(noteID: "Nota 01", content: "Essa é uma nota de teste, oi tudo bem com você?")), NoteCellViewModel.init(note: NoteDummy(noteID: "Nota 02", content: "Essa é uma outra nota de teste, oi tudo bem com você?")), NoteCellViewModel.init(note: NoteDummy(noteID: "Nota 03", content: "Essa é uma outra outra nota de teste, oi tudo bem com você?"))]
        sut = .init(palette: palette, repository: repositoryDummy)
        
        let navigation = NavigationController(rootViewController: sut)
        return navigation
    }
}
