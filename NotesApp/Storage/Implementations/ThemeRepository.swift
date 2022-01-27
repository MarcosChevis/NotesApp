//
//  ThemeRepository.swift
//  NotesApp
//
//  Created by Marcos Chevis on 27/01/22.
//

import UIKit

class ThemeRepository: ThemeRepositoryProtocol {
    
    
    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }
    
    func getAllThemes() -> [ThemeProtocol] {
        let request = Theme.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Theme.name, ascending: true)]
        do {
            let themes = try coreDataStack.mainContext.fetch(request)
            return themes
        } catch {
            return []
        }
    }
    
    func createEmptyTheme() -> ThemeProtocol {
        Theme(context: coreDataStack.mainContext)
    }
    
    func saveChanges() {
        do {
            try coreDataStack.save()
        } catch {
            coreDataStack.mainContext.rollback()
        }
    }
    
    func cancelChanges() {
        coreDataStack.mainContext.rollback()
    }
    

}
