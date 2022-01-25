//
//  SettingsViewTest.swift
//  NotesAppTests
//
//  Created by Caroline Taus on 24/01/22.
//

import XCTest
import SnapshotTesting
@testable import NotesApp

class SettingsViewTest: XCTestCase {
    
    var sut: SettingsViewController!
    var colorSet: ColorSet!

    override func setUp() {
        colorSet = .classic
        sut = .init(palette: colorSet, tableDataSource: SettingTableDataSource(palette: colorSet))
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
        colorSet = nil
    }

    func setupLayoutTest(with palette: ColorSet = .classic) -> UIViewController {
        sut = .init(palette: palette, tableDataSource: SettingTableDataSource(palette: palette))
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
        let view = setupLayoutTest(with: .grape)
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
