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
    
    var sut: NoteViewController!
    var colorSet: ColorSet!

    override func setUp() {
        colorSet = .classic
        sut = .init(palette: colorSet)
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
        colorSet = nil
    }

    func setupLayoutTest(with palette: ColorSet = .classic) -> UIViewController {
        sut = .init(palette: palette)
        let navigation = NavigationController(rootViewController: sut)
        return navigation
    }
    
    func testLayoutWithMoreThanOneItemOnIphone12() {
        let view = setupLayoutTestWithMoreThanItem()
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    
    func testLayoutWithMoreThanOneItemOnIphoneSE() {
        let view = setupLayoutTestWithMoreThanItem()
        assertSnapshot(matching: view, as: .image(on: .iPhoneSe))
    }
    
    func testLayoutWithMoreThanOneItemOnIphone12ProMax() {
        let view = setupLayoutTestWithMoreThanItem()
        assertSnapshot(matching: view, as: .image(on: .iPhone12ProMax))
    }

    

}
