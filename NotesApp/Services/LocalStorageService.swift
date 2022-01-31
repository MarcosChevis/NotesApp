//
//  LocalStorageService.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import Foundation

protocol LocalStorageService {
    func object(forKey: String) -> Any?
    func string(forKey: String) -> String?
    
    func set(_ value: Any?, forKey: String)
}

extension UserDefaults: LocalStorageService {}
