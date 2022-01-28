//
//  ThemeRepositoryProtocol.swift
//  NotesApp
//
//  Created by Marcos Chevis on 27/01/22.
//

import Foundation

protocol ThemeRepositoryProtocol {
    func getAllThemes() -> [ColorSet]
        
    func createEmptyTheme() -> ThemeProtocol
    
    func saveChanges()
    
    func cancelChanges()
    
    func getTheme(with id: String) -> ColorSet?
    
}



