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
    var themeRepository: ThemeRepositoryProtocol!
    

    override func setUp() {
        coordinatorDummy = .init()
        notificationServiceDummy = .init()
        localStorageServiceDummy = .init()
        themeRepository = ThemeRepository(coreDataStack: CoreDataStack(.inMemory))
        settings = .init(localStorageService: localStorageServiceDummy, notificationService: notificationServiceDummy, themeRepository: themeRepository)
        sut = ThemesViewController(palette: .classic, collectionDataSource: ThemesCollectionDataSource(), notificationService: notificationServiceDummy, settings: settings, themeRepository: themeRepository)
        sut.coordinator = coordinatorDummy
        _ = sut.view
        sut.viewDidAppear(true)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testDidSelectTheme() {
        selectTheme(at: 1)
        sut.collectionDataSource.data.forEach { theme in
            if theme.colorSet == themeRepository.getTheme(with: "50fab20d-3934-4a4a-8274-1ad502544a06") {
                XCTAssertTrue(theme.isSelected)
            }
            else {
                XCTAssertFalse(theme.isSelected)
            }
        }
    }
    
    func testDidChangeTheme() {
        XCTAssertEqual(.classic, settings.theme)
        selectTheme(at: 4)
        XCTAssertEqual(themeRepository.getTheme(with: "224462ed-d295-4ba7-a9bd-9b986ba751df"), settings.theme)
    }
    
    func testDidChangePalette() {
        XCTAssertEqual("didChangeTheme:", notificationServiceDummy.observers.first!)
        XCTAssertEqual([], notificationServiceDummy.postedNotification)
        selectTheme(at: 2)
        XCTAssertEqual(.init("ThemeManager_DidChangeTheme"), notificationServiceDummy.postedNotification.first!)
        XCTAssertEqual(themeRepository.getTheme(with: "6bcb4b2d-6afa-4a2a-b4dc-f2cca83a44c7"), notificationServiceDummy.postedObjects.first as? ColorSet)
    }
    
    func selectTheme(at index: Int) {
        sut.collectionView(sut.contentView.collectionView, didSelectItemAt: IndexPath(row: index, section: 0))
    }
    
}
