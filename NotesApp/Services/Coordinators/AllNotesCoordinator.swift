//
//  AllNotesCoordinator.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

protocol AllNotesCoordinatorProtocol: AnyObject, AlertCoordinatorProtocol, NoteShareCoordinatorProtocol {
    func dismiss()
    func editNote(with id: String)
    func navigateToSettings()
    func navigateToThemes()
    func navigateToCustomTheme()
    func editCustomTheme(with id: String)
}

class AllNotesCoordinator: CoordinatorProtocol, AllNotesCoordinatorProtocol {
    let navigationController: NavigationController
    var settings: Settings
    let notificationService: NotificationService
    var childCoordinators: [CoordinatorProtocol]
    
    weak var delegate: AllNotesCoordinatorDelegate?
    
    init(navigationController: NavigationController,
         settings: Settings = .shared,
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
        dismiss(with: nil)
    }
    
    func editNote(with id: String) {
        dismiss(with: id)
    }
    
    private func dismiss(with id: String?) {
        navigationController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            if let id = id {
                self.delegate?.didDismissToNote(with: id)
            } else {
                self.delegate?.didDismiss()
            }
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
    }
    
    func editCustomTheme(with id: String) {
        let childCoordinator = CustomThemeBuilderCoordinator(navigationController: NavigationController(), themeId: id)
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
        childCoordinator.delegate = self
        navigationController.present(childCoordinator.navigationController, animated: true, completion: nil)
    }
}

extension AllNotesCoordinator: CustomThemeBuilderCoordinatorDelegate {
    func didDismiss() {
        childCoordinators.removeAll(where: {
            ($0 as? CustomThemeBuilderCoordinator) != nil
        })
    }
    
    
}
