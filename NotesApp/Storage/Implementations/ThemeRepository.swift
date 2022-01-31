//
//  ThemeRepository.swift
//  NotesApp
//
//  Created by Marcos Chevis on 27/01/22.
//

import UIKit

class ThemeRepository: ThemeRepositoryProtocol {
    private let coreDataStack: CoreDataStack
    private var standardThemes: [ColorSet]
    private var customThemes: [ColorSet]
    
    static let shared = ThemeRepository()

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
        self.standardThemes = []
        self.customThemes = []
        
        self.standardThemes = getAllStandardThemes()
        self.customThemes = getAllCustomThemes()
    }
    
    func getAllThemes() -> [ColorSet] {
        return customThemes + standardThemes
    }
    
    private func getAllCustomThemes() -> [ColorSet] {
        let request = Theme.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Theme.name, ascending: true)]
        do {
            let themes = try coreDataStack.mainContext.fetch(request)
            return themes.map(ColorSet.init)
        } catch {
            return []
        }
    }
    
    private func getAllStandardThemes() -> [ColorSet] {
        
        let standardThemes = JSONDecoder().decode(from: "StandardThemes", decodeTo: [StandardTheme].self) ?? []
        
        return standardThemes.map(ColorSet.init)
    }
    
    func createEmptyTheme() -> ThemeProtocol {
        let theme = Theme(context: coreDataStack.mainContext)
        theme.id = UUID()
        return theme
    }
    
    func saveChanges() {
        do {
            try coreDataStack.save()
            customThemes = getAllCustomThemes()
            
        } catch {
            coreDataStack.mainContext.rollback()
        }
        
    }
    
    func cancelChanges() {
        coreDataStack.mainContext.rollback()
    }
    
    func getTheme(with id: String) -> ColorSet? {
        
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
    
    private func getThemeFromStandard(with id: String) -> ColorSet? {
        return standardThemes.first { colorSet in
            return colorSet.id == id
        }
    }
    
    private func getThemeFromCustom(with id: String) -> ColorSet? {
        return customThemes.first { colorSet in
            return colorSet.id == id
        }
    }
    

}
