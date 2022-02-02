//
//  ThemeRepositoryProtocol.swift
//  NotesApp
//
//  Created by Marcos Chevis on 27/01/22.
//

import Foundation

protocol ThemeRepositoryProtocol {
    func getAllColorSets() -> [ColorSet]
        
    func createEmptyTheme() -> ThemeProtocol
    
    func saveChanges()
    
    func cancelChanges()
    
    func getColorSet(with id: String) -> ColorSet?
    
    func getTheme(with id: String) -> ThemeProtocol?
    
}



