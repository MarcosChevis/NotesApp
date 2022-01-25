//
//  ThemesViewTest.swift
//  NotesAppTests
//
//  Created by Rebecca Mello on 24/01/22.
//

import XCTest
import SnapshotTesting
@testable import NotesApp

class ThemesViewTest: XCTestCase {
    
    var sut: ThemesViewController!
    var colorSet: ColorSet!

    override func setUp() {
        colorSet = .classic
        sut = .init(palette: colorSet, collectionDataSource: ThemesCollectionDataSouce())
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
        colorSet = nil
    }

    func setupLayoutTest(with palette: ColorSet = .classic) -> UIViewController {
        sut = .init(palette: palette, collectionDataSource: ThemesCollectionDataSouce())
        let navigation = NavigationController(rootViewController: sut)
        return navigation
    }
    
    func testLayoutIphone12() {
        let view = setupLayoutTest()
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    
    func testLayoutOnIphoneSE() {
        let view = setupLayoutTest()
        assertSnapshot(matching: view, as: .image(on: .iPhoneSe))
    }
    
    func testLayoutOnIphone12ProMax() {
        let view = setupLayoutTest()
        assertSnapshot(matching: view, as: .image(on: .iPhone12ProMax))
    }
    
    func testLayoutIphone12neon() {
        let view = setupLayoutTest(with: .neon)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutIphone12pastel() {
        let view = setupLayoutTest(with: .candy)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutIphone12bookish() {
        let view = setupLayoutTest(with: .bookish)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutIphone12christmas() {
        let view = setupLayoutTest(with: .christmas)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

}
