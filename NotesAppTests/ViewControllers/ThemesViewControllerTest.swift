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
        sut = ThemesViewController(palette: colorSet, collectionDataSource: ThemesCollectionDataSouce(), notificationService: notificationServiceDummy, settings: settings)
        sut.coordinator = coordinatorDummy
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }
    
    func testDidSelectTheme() {
        sut.collectionDataSource(
    }
}
