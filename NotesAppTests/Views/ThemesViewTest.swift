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
    var themeRepository: ThemeRepositoryProtocol!

    override func setUp() {
        colorSet = .classic
        themeRepository = ThemeRepository(coreDataStack: .init(.inMemory))
        sut = .init(palette: colorSet, collectionDataSource: ThemesCollectionDataSource())
        isRecording = false
    }
    
    override func tearDown() {
        sut = nil
        colorSet = nil
    }

    func setupLayoutTest(with palette: ColorSet = .classic) -> UIViewController {
        sut = .init(palette: palette, collectionDataSource: ThemesCollectionDataSource(), notificationService: NotificationServiceDummy(), settings: Settings(localStorageService: LocalStorageServiceDummy(), notificationService: NotificationServiceDummy()))
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
    
    func testLayoutOnIphone12neon() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "224462ed-d295-4ba7-a9bd-9b986ba751df") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testLayoutOnIphone12bookish() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "bc09ce57-6039-445f-83e4-c7165b4afc79") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testLayoutOnIphone12grape() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "6bcb4b2d-6afa-4a2a-b4dc-f2cca83a44c7") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testLayoutOnIphone12christmas() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "a1c6b360-2b91-473c-b24e-8a95d3ed45d9") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutOnIphone12dark() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "50fab20d-3934-4a4a-8274-1ad502544a06") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutOnIphone12halloween() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "bf2ae775-8660-4e33-88d3-0676bdf47572") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutOnIphone12devotional() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "0765f920-170e-4521-b077-cd496917f21b") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

    func testLayoutOnIphone12matrix() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "f5e3ec97-1b02-46f2-b2de-0592d7fe48b5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }
    
    func testLayoutOnIphone12unicorn() {
        let view = setupLayoutTest(with: themeRepository.getTheme(with: "8de332a6-2120-45b8-b638-f2c86b017aa5") ?? .classic)
        assertSnapshot(matching: view, as: .image(on: .iPhone12))
    }

}
