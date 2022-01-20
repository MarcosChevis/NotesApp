//
//  MainCoordinator.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    func navigateToAllNotes()
}

class MainCoordinator: NSObject, CoordinatorProtocol, MainCoordinatorProtocol {
    let navigationController: UINavigationController
    let settings: Settings
    var childCoordinators: [CoordinatorProtocol]
    let notificationService: NotificationService
    
    init(navigationController: UINavigationController,
         settings: Settings = Settings(localStorageService: UserDefaults.standard,
                                       notificationService: NotificationCenter.default),
         notificationService: NotificationService = NotificationCenter.default)
    {
        self.navigationController = navigationController
        self.settings = settings
        self.childCoordinators = []
        self.notificationService = notificationService
        super.init()
        notificationService.addObserver(self, selector: #selector(didComeBackFromModal), name: .didComebackFromModal, object: nil)
    }
    
    deinit {
        notificationService.removeObserver(self)
    }
    
    func start() {
        let vc = NoteViewController(palette: settings.theme, repository: NotesRepository())
        navigationController.pushViewController(vc, animated: false)
        vc.coordinator = self
    }
    
    func navigateToAllNotes() {
        let childCoordinator = AllNotesCoordinator(navigationController: UINavigationController(), settings: settings)
        childCoordinator.start()
        childCoordinators.append(childCoordinator)
        navigationController.present(childCoordinator.navigationController, animated: true)
    }
    
    @objc private func didComeBackFromModal() {
        childCoordinators.removeAll(where: {
            ($0 as? AllNotesCoordinator) != nil
        })
    }
}
