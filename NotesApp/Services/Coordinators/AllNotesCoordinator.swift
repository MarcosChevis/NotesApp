//
//  AllNotesCoordinator.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

protocol AllNotesCoordinatorProtocol: AnyObject {
    func dismiss()
    func navigateToSettings()
    func navigateToThemes()
    func navigateToCustomTheme()
}

class AllNotesCoordinator: CoordinatorProtocol, AllNotesCoordinatorProtocol {
    let navigationController: NavigationController
    var settings: Settings
    let notificationService: NotificationService
    var childCoordinators: [CoordinatorProtocol]
    
    init(navigationController: NavigationController,
         settings: Settings = Settings(localStorageService: UserDefaults.standard,
                                       notificationService: NotificationCenter.default),
         notificationService: NotificationService = NotificationCenter.default)
    {
        self.navigationController = navigationController
        self.settings = settings
        self.childCoordinators = []
        self.notificationService = notificationService
    }
    
    func start() {
        navigationController.modalPresentationStyle = .fullScreen
        let vc = AllNotesViewController(palette: settings.theme)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true) { [weak notificationService] in
            notificationService?.post(name: .didComebackFromModal, object: nil)
        }
    }
    
    func navigateToSettings() {
        let vc = SettingsViewController(palette: settings.theme, tableDataSource: .init(palette: settings.theme))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToThemes() {
        let vc = ThemesViewController(palette: settings.theme, collectionDataSource: .init())
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToCustomTheme() {
        let childCoordinator = CustomThemeBuilderCoordinator(navigationController: NavigationController())
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
        childCoordinator.delegate = self
        navigationController.present(childCoordinator.navigationController, animated: true, completion: nil)
        print(childCoordinators)
    }
}

extension AllNotesCoordinator: CustomThemeBuilderCoordinatorDelegate {
    func didDismiss() {
        childCoordinators.removeAll(where: {
            ($0 as? CustomThemeBuilderCoordinator) != nil
        })
        print(childCoordinators)
    }
    
    
}
