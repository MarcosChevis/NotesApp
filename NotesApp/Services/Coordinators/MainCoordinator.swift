//
//  MainCoordinator.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject, AlertCoordinatorProtocol, NoteShareCoordinatorProtocol {
    func navigateToAllNotes()
}

class MainCoordinator: CoordinatorProtocol, MainCoordinatorProtocol {
    let navigationController: NavigationController
    let settings: Settings
    var childCoordinators: [CoordinatorProtocol]
    let notificationService: NotificationService
    
    init(navigationController: NavigationController,
         settings: Settings = .shared,
         notificationService: NotificationService = NotificationCenter.default)
    {
        self.navigationController = navigationController
        self.settings = settings
        self.childCoordinators = []
        self.notificationService = notificationService
    }
    
    deinit {
        notificationService.removeObserver(self)
    }
    
    func start() {
        let theme = settings.theme
        let vc = NoteViewController(contentView: NoteView(palette: theme), palette: theme, repository: NotesRepository())
        navigationController.pushViewController(vc, animated: false)
        vc.coordinator = self
    }
    
    func navigateToAllNotes() {
        let childCoordinator = AllNotesCoordinator(navigationController: NavigationController(), settings: settings)
        childCoordinator.delegate = self
        childCoordinator.start()
        childCoordinators.append(childCoordinator)
        navigationController.present(childCoordinator.navigationController, animated: true)
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

extension MainCoordinator: AllNotesCoordinatorDelegate {
    func didDismiss() {
        childCoordinators.removeAll(where: {
            ($0 as? AllNotesCoordinator) != nil
        })
        
        print(childCoordinators)
    }
    
    func didDismissToNote(with id: String) {
        didDismiss()
        scrollToCurrentItem(with: id)
    }
}
