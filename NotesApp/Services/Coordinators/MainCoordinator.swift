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

class MainCoordinator: CoordinatorProtocol, MainCoordinatorProtocol {
    let navigationController: NavigationController
    let settings: Settings
    var childCoordinators: [CoordinatorProtocol]
    let notificationService: NotificationService
    
    init(navigationController: NavigationController,
         settings: Settings = Settings(localStorageService: UserDefaults.standard,
                                       notificationService: NotificationCenter.default),
         notificationService: NotificationService = NotificationCenter.default)
    {
        self.navigationController = navigationController
        self.settings = settings
        self.childCoordinators = []
        self.notificationService = notificationService
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
        let childCoordinator = AllNotesCoordinator(navigationController: NavigationController(), settings: settings)
        childCoordinator.start()
        childCoordinators.append(childCoordinator)
        navigationController.present(childCoordinator.navigationController, animated: true)
    }
    
    @objc private func didComeBackFromModal(_ notification: Notification) {
        childCoordinators.removeAll(where: {
            ($0 as? AllNotesCoordinator) != nil
        })
        
        guard
            let id = notification.object as? String
        else { return }
        
        scrollToCurrentItem(with: id)
    }
    
    private func scrollToCurrentItem(with id: String?) {
        guard let rootVC = navigationController.viewControllers.first as? NoteViewController else {
            return
        }
        
        if let id = id {
            rootVC.highlightNote(with: id)
        }
    }
    
}
