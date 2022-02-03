//
//  ThemeRepositoryTest.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 02/02/22.
//

import XCTest
@testable import NotesApp

class ThemeRepositoryTest: XCTestCase {
    
    var sut: ThemeRepository!
    var coreDataStack: CoreDataStack!

    override func setUp() {
        coreDataStack = .init(.inMemory)
        sut = .init(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        sut = nil
        coreDataStack = nil
    }
    
    func testCreateNewTheme() throws {
        let theme = sut.createEmptyTheme()
        XCTAssertNotNil(theme.id)
    }
    
    func testGetAllColorSets() {
        setupInitialData()
        
        let themes = sut.getAllColorSets()
        XCTAssertEqual(11, themes.count)
        XCTAssertEqual(10, themes.map(\.isStandard).filter{ $0 }.count)
    }
    
    func testSaveChanges() {
        setupInitialData()
        XCTAssertEqual(11, sut.getAllColorSets().count)
        
        _ = createTheme()
        sut.saveChanges()
        
        XCTAssertEqual(12, sut.getAllColorSets().count)
        XCTAssertEqual(2, sut.getAllColorSets().map(\.isStandard).filter { !$0 }.count)
    }
    
    func testCancelChanges() {
        setupInitialData()
        
        _ = createTheme()
        sut.cancelChanges()
        
        let count = try! coreDataStack.mainContext.count(for: Theme.fetchRequest())
        
        XCTAssertEqual(1, count)
    }
    
    func testGetColorSet() {
        let neonID = "224462ed-d295-4ba7-a9bd-9b986ba751df"
        let theme = sut.getColorSet(with: neonID)
        
        XCTAssertNotNil(theme)
        XCTAssertEqual("Neon", theme?.name)
    }
    
    func testGetThemeWithStandardID() {
        let neonID = "224462ed-d295-4ba7-a9bd-9b986ba751df"
        let theme = sut.getTheme(with: neonID)
        XCTAssertNil(theme)
    }
    
    func testGetThemeWithCoreDataID() {
        let id = setupInitialData().id!.uuidString
        let theme = sut.getTheme(with: id)
        
        XCTAssertNotNil(theme)
        XCTAssertEqual(theme!.name!, "Some Custom")
    }
    
    func testDeleteThemeWithStandardID() {
        let neonID = "224462ed-d295-4ba7-a9bd-9b986ba751df"
        XCTAssertThrowsError(try sut.deleteTheme(with: neonID))
    }
    
    func testDeleteThemeWithCoreDataID() {
        let id = setupInitialData().id!.uuidString
        XCTAssertNoThrow(try sut.deleteTheme(with: id))
        XCTAssertEqual(10, sut.getAllColorSets().count)
    }
    
    @discardableResult
    private func setupInitialData() -> ThemeProtocol {
        let theme = createTheme()
        sut.saveChanges()
        return theme
    }
    
    private func createTheme() -> ThemeProtocol {
        let colorSet = ColorSet.classic
        var theme = sut.createEmptyTheme()
        theme.noteBackground = colorSet.noteBackground
        theme.text = colorSet.text
        theme.buttonBackground = colorSet.buttonBackground
        theme.largeTitle = colorSet.largeTitle
        theme.actionColor = colorSet.actionColor
        theme.background = colorSet.background
        theme.name = "Some Custom"
        
        return theme
    }

}
