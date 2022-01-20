//
//  LocalStorageServiceDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

@testable import NotesApp

class LocalStorageServiceDummy: LocalStorageService {
    func object(forKey: String) -> Any? {
        return values[forKey]
    }
    
    func string(forKey: String) -> String? {
        return values[forKey] as? String
    }
    
    func set(_ value: Any?, forKey: String) {
        values[forKey] = value
    }
    
    var values: [String : Any] = [:]
}
