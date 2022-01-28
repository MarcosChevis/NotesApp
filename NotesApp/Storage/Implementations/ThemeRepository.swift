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
    
    func getAllThemes() -> [CustomColorSet] {
        let customThemes = getAllCustomThemes()
        let standardThemes = getAllStandardThemes()
        
        return customThemes + standardThemes
    }
    
    private func getAllCustomThemes() -> [CustomColorSet] {
        let request = Theme.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Theme.name, ascending: true)]
        do {
            let themes = try coreDataStack.mainContext.fetch(request)
            return themes.map(CustomColorSet.init)
        } catch {
            return []
        }
    }
    
    private func getAllStandardThemes() -> [CustomColorSet] {
        return []
    }
    
    func createEmptyTheme() -> ThemeProtocol {
        let theme = Theme(context: coreDataStack.mainContext)
        theme.id = UUID()
        return theme
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
    
    func getTheme(with id: String) -> CustomColorSet? {
        
        //procurar no json os temas padroes
        if let theme = getThemeFromStandard(with: id) {
            return theme
        }
        
        //procurar no coreData
        if let theme = getThemeFromCustom(with: id) {
            return theme
        }
        
        return nil
    }
    
    private func getThemeFromStandard(with id: String) -> CustomColorSet? {
        return nil
    }
    
    private func getThemeFromCustom(with id: String) -> CustomColorSet? {
        return nil
    }
    

}
