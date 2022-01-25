//
//  ThemesViewControllerTest.swift
//  NotesAppTests
//
//  Created by Rebecca Mello on 25/01/22.
//

import XCTest
@testable import NotesApp

class ThemesViewControllerTest: XCTestCase {
    
    var sut: ThemesViewController!
    var colorSet: ColorSet!
    var coordinatorDummy: AllNotesCoordinatorDummy!
    var localStorageServiceDummy: LocalStorageServiceDummy!
    var notificationServiceDummy: NotificationServiceDummy!
    var settings: Settings!
    

    override func setUp() {
        coordinatorDummy = .init()
        notificationServiceDummy = .init()
        localStorageServiceDummy = .init()
        settings = .init(localStorageService: localStorageServiceDummy, notificationService: notificationServiceDummy)
        sut = ThemesViewController(palette: .classic, collectionDataSource: ThemesCollectionDataSouce(), notificationService: notificationServiceDummy, settings: settings)
        sut.coordinator = coordinatorDummy
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }
    
    func testDidSelectTheme() {
        selectTheme(at: 1)
        sut.collectionDataSource.data.forEach { theme in
            if theme.colorSet == .neon {
                XCTAssertTrue(theme.isSelected)
            }
            else {
                XCTAssertFalse(theme.isSelected)
            }
        }
    }
    
    func testDidChangeTheme() {
        XCTAssertEqual(.classic, settings.theme)
        selectTheme(at: 2)
        XCTAssertEqual(.christmas, settings.theme)
    }
    
    func testDidChangePalette() {
        XCTAssertEqual("didChangeTheme:", notificationServiceDummy.observers.first!)
        XCTAssertEqual([], notificationServiceDummy.postedNotification)
        selectTheme(at: 2)
        XCTAssertEqual(.init("ThemeManager_DidChangeTheme"), notificationServiceDummy.postedNotification.first!)
        XCTAssertEqual(.christmas, notificationServiceDummy.postedObjects.first! as! ColorSet)
    }
    
    func selectTheme(at index: Int) {
        sut.collectionView(sut.contentView.collectionView, didSelectItemAt: IndexPath(row: index, section: 0))
    }
    
}
