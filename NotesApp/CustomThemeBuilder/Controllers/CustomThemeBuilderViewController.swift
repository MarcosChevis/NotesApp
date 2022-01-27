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
    
    lazy var customColorSet: ThemeProtocol = {
        let colorSet = palette.palette()
        var theme = repository.createEmptyTheme()
        theme.actionColor = colorSet.actionColor
        theme.buttonBackground = colorSet.buttonBackground
        theme.largeTitle = colorSet.largeTitle
        theme.noteBackground = colorSet.noteBackground
        theme.background = colorSet.background
        theme.text = colorSet.text
        
        return theme
    }()
    
    var willChange: Int
    
    private let repository: ThemeRepositoryProtocol

    init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
                  settings: Settings = Settings(), themeRepository: ThemeRepositoryProtocol = ThemeRepository()) {
        
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
        let vc = UIColorPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
        
    }
}

extension CustomThemeBuilderViewController: CustomThemeBuilderViewDelegate {
    func didTapSave() {
        repository.saveChanges()
        print(repository.getAllThemes())
    }
    
    func didTapCancel() {
        repository.cancelChanges()
        print(repository.getAllThemes())
    }
    
}

extension CustomThemeBuilderViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         guard let text = textField.text else { return true }
         let newLength = text.count + string.count - range.length
         return newLength <= 15
    }
}
