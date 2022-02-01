//
//  CustomThemeBuilderViewControllerTest.swift
//  NotesAppTests
//
//  Created by Marcos Chevis on 31/01/22.
//

import XCTest
@testable import NotesApp

class CustomThemeBuilderViewControllerTest: XCTestCase {
    
    var sut: CustomThemeBuilderViewController!
    var colorSet: ColorSet!
    var notificationServiceDummy: NotificationServiceDummy!
    var settings: Settings!
    var themeRepository: ThemeRepositoryProtocol!
    var localStorageServiceDummy: LocalStorageServiceDummy!
    var coordinatorDummy: CustomThemeBuilderCoordinatorDummy!
    
    override func setUp() {
        colorSet = .classic
        notificationServiceDummy = .init()
        localStorageServiceDummy = .init()
        themeRepository = ThemeRepository(coreDataStack: .init(.inMemory))
        coordinatorDummy = CustomThemeBuilderCoordinatorDummy()
        
        settings = .init(localStorageService: localStorageServiceDummy, notificationService: notificationServiceDummy, themeRepository: themeRepository)
        
        sut = CustomThemeBuilderViewController(palette: colorSet, notificationService: notificationServiceDummy, settings: settings, themeRepository: themeRepository)
        
        sut.coordinator = coordinatorDummy
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testDidChangeColor() {
        sut.contentView.collectionView.delegate?.collectionView?(sut.contentView.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        coordinatorDummy.selectColor = .blue
        sut.coordinator?.showColorPicker(delegate: sut, color: sut.customThemeBuilderColectionViewDataSource.data[0].color ?? .clear)
        
        XCTAssertEqual(sut.customThemeBuilderColectionViewDataSource.data[0].color, UIColor.blue)
        XCTAssertEqual(sut.contentView.exampleView.backgroundColor, UIColor.blue)
        XCTAssertEqual(sut.customColorSet.background, UIColor.blue)
    }
    
    func testDidSaveCustomColorSetToCoreData() {
        sut.contentView.themeNameTextField.text = "Teste Título"
        sut.didTapSave()
        
        //11 = 10 temas padroes + 1 tema criado agr
        XCTAssertEqual(themeRepository.getAllThemes().count, 11)
        XCTAssertEqual(coordinatorDummy.didDismiss, true)
    }
    
    func testDidDismissWithoutSave() {
        sut.contentView.themeNameTextField.text = "Teste Título"
        sut.didTapCancel()
        
        //10 temas padroes
        XCTAssertEqual(themeRepository.getAllThemes().count, 10)
        XCTAssertEqual(coordinatorDummy.didDismiss, true)
    }


}
