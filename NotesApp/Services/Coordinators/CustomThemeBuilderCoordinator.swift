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
    func showColorPicker(delegate: UIColorPickerViewControllerDelegate)
}

class CustomThemeBuilderCoordinator: CoordinatorProtocol, CustomThemeBuilderCoordinatorProtocol {
    
    var navigationController: NavigationController
    var childCoordinators: [CoordinatorProtocol]
    var settings: Settings
    weak var delegate: CustomThemeBuilderCoordinatorDelegate?
    
    init(navigationController: NavigationController, settings: Settings = .shared) {
        self.navigationController = navigationController
        self.settings = settings
        self.childCoordinators = []
    }
    
    func start() {
        navigationController.modalPresentationStyle = .fullScreen
        let vc = CustomThemeBuilderViewController(palette: settings.theme)
        navigationController.pushViewController(vc, animated: false)
        vc.coordinator = self
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: { [weak self] in
            self?.delegate?.didDismiss()
        })
    }
    
    func showColorPicker(delegate: UIColorPickerViewControllerDelegate) {
        let vc = UIColorPickerViewController()
        vc.delegate = delegate
        navigationController.present(vc, animated: true)
    }
    
}
