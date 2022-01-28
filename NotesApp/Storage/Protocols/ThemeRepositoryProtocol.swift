//
//  ThemeRepositoryProtocol.swift
//  NotesApp
//
//  Created by Marcos Chevis on 27/01/22.
//

import Foundation

protocol ThemeRepositoryProtocol {
    func getAllThemes() -> [CustomColorSet]
        
    func createEmptyTheme() -> ThemeProtocol
    
    func saveChanges()
    
    func cancelChanges()
    
    func getTheme(with id: String) -> CustomColorSet?
    
}



