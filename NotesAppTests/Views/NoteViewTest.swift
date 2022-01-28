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

//    func testLayoutWithMoreThanOneItemOnIphone12bookish() {
//        let view = setupLayoutTestWithMoreThanItem(with: .bookish)
//        assertSnapshot(matching: view, as: .image(on: .iPhone12))
//    }
//
//    func testLayoutWithMoreThanOneItemOnIphone12pastel() {
//        let view = setupLayoutTestWithMoreThanItem(with: .grape)
//        assertSnapshot(matching: view, as: .image(on: .iPhone12))
//    }
//
//    func testLayoutWithMoreThanOneItemOnIphone12christmas() {
//        let view = setupLayoutTestWithMoreThanItem(with: .christmas)
//        assertSnapshot(matching: view, as: .image(on: .iPhone12))
//    }
    
    
    func setupLayoutTestWithMoreThanItem(with palette: ColorSet) -> UIViewController {
        repositoryDummy.mock = [NoteCellViewModel.init(note: NoteDummy(noteID: "Nota 01", content: "Essa é uma nota de teste, oi tudo bem com você?")), NoteCellViewModel.init(note: NoteDummy(noteID: "Nota 02", content: "Essa é uma outra nota de teste, oi tudo bem com você?")), NoteCellViewModel.init(note: NoteDummy(noteID: "Nota 03", content: "Essa é uma outra outra nota de teste, oi tudo bem com você?"))]
        sut = .init(palette: palette, repository: repositoryDummy)
        
        let navigation = NavigationController(rootViewController: sut)
        return navigation
    }
}
