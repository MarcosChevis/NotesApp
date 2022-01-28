//
//  CustomThemeBuilderViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 26/01/22.
//

import UIKit

class CustomThemeBuilderViewController: ThemableViewController {
    
    lazy var customThemeBuilderColectionViewDataSource: CustomThemeBuilderCollectionViewDataSource = {
        return CustomThemeBuilderCollectionViewDataSource(colorSet: customColorSet, palette: palette)
    }()
    
    var contentView: CustomThemeBuilderView
    weak var coordinator: CustomThemeBuilderCoordinatorProtocol?
    
    lazy var customColorSet: ThemeProtocol = {
        
        var theme = repository.createEmptyTheme()
        theme.actionColor = palette.actionColor
        theme.buttonBackground = palette.buttonBackground
        theme.largeTitle = palette.largeTitle
        theme.noteBackground = palette.noteBackground
        theme.background = palette.background
        theme.text = palette.text
        
        return theme
    }()
    
    var willChange: Int
    
    private let repository: ThemeRepositoryProtocol

    init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = .shared, themeRepository: ThemeRepositoryProtocol = ThemeRepository()) {
        
        self.contentView = .init(palette: palette)
        self.willChange = -1
        self.repository = themeRepository
        
        super.init(palette: palette, notificationService: notificationService, settings: settings)

        self.view = self.contentView
        self.contentView.delegate = self
        self.contentView.themeNameTextView.delegate = self
        self.contentView.collectionView.dataSource = customThemeBuilderColectionViewDataSource
        self.contentView.collectionView.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = false
        setupBarButtonItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBarButtonItems() {
        navigationItem.leftBarButtonItem = contentView.cancelButton
        navigationItem.rightBarButtonItem = contentView.saveButton
    }
    
    
}

extension CustomThemeBuilderViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        if willChange > -1 {
            customThemeBuilderColectionViewDataSource.data[willChange].color = color
            contentView.collectionView.reloadItems(at: [IndexPath(row: willChange, section: 0)])
            
            switch willChange {
            case 0:
                customColorSet.background = color
            case 1:
                customColorSet.noteBackground = color
            case 2:
                customColorSet.text = color
            case 3:
                customColorSet.largeTitle = color
            case 4:
                customColorSet.buttonBackground = color
            case 5:
                customColorSet.actionColor = color
            default:
                break
            }
            
            contentView.exampleView.setColorsForCustomTheme(colorSet: customColorSet)
        }
    }
}

extension CustomThemeBuilderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.willChange = indexPath.row
        coordinator?.showColorPicker(delegate: self)
    }
}

extension CustomThemeBuilderViewController: CustomThemeBuilderViewDelegate {
    func didTapSave() {
        repository.saveChanges()
        coordinator?.dismiss()
    }
    
    func didTapCancel() {
        repository.cancelChanges()
        coordinator?.dismiss()
    }
    
}

extension CustomThemeBuilderViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         guard let text = textField.text else { return true }
         let newLength = text.count + string.count - range.length
         return newLength <= 15
    }
}
