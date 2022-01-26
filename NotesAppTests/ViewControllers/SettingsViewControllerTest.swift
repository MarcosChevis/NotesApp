//
//  SettingsViewControllerTest.swift
//  NotesAppTests
//
//  Created by Rebecca Mello on 21/01/22.
//

import XCTest
@testable import NotesApp

class SettingsViewControllerTest: XCTestCase {
    
    var sut: SettingsViewController!
    var coordinatorDummy: AllNotesCoordinatorDummy!
    var settings: Settings!
    var localStorageServiceDummy: LocalStorageServiceDummy!
    var notificationServiceDummy: NotificationServiceDummy!
    
    override func setUp() {
        coordinatorDummy = .init()
        localStorageServiceDummy = .init()
        notificationServiceDummy = .init()
        settings = .init(localStorageService: localStorageServiceDummy, notificationService: notificationServiceDummy)
        sut = SettingsViewController(palette: .classic, tableDataSource: SettingTableDataSource(palette: .classic), notificationService: notificationServiceDummy, settings: settings)
        sut.coordinator = coordinatorDummy
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }

    func testDidNavigateToThemes() {
        sut.tableView(sut.contentView.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(coordinatorDummy.didNavigateToThemes)
    }
}
