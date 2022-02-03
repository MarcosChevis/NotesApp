//
//  ThemeBuilderCordinator.swift
//  NotesApp
//
//  Created by Marcos Chevis on 28/01/22.
//

import Foundation
import UIKit

protocol CustomThemeBuilderCoordinatorProtocol: AnyObject, AlertCoordinatorProtocol {
    func dismiss()
    func showColorPicker(delegate: UIColorPickerViewControllerDelegate, color: UIColor)
}

class CustomThemeBuilderCoordinator: CoordinatorProtocol, CustomThemeBuilderCoordinatorProtocol {
    
    var navigationController: NavigationController
    var childCoordinators: [CoordinatorProtocol]
    var settings: Settings
    weak var delegate: CustomThemeBuilderCoordinatorDelegate?
    var themeId: String?
    
    init(navigationController: NavigationController, settings: Settings = .shared, themeId: String? = nil) {
        self.navigationController = navigationController
        self.settings = settings
        self.childCoordinators = []
        self.themeId = themeId
    }
    
    func start() {
        navigationController.modalPresentationStyle = .fullScreen
        let vc = CustomThemeBuilderViewController(palette: settings.theme, themeId: themeId)
        navigationController.pushViewController(vc, animated: false)
        vc.coordinator = self
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: { [weak self] in
            self?.delegate?.didDismiss()
        })
    }
    
    func showColorPicker(delegate: UIColorPickerViewControllerDelegate, color: UIColor) {
        let vc = UIColorPickerViewController()
        vc.delegate = delegate
        vc.selectedColor = color
        navigationController.present(vc, animated: true)
    }
    
}
