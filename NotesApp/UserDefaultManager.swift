//
//  UserDefaultManager.swift
//  NotesApp
//
//  Created by Marcos Chevis on 17/01/22.
//

import Foundation

struct Settings {
    
    @LocalStorage(key: "chavoso", defaultValue: ColorSet.classic.rawValue)
    var theme: String
    
}

@propertyWrapper
struct LocalStorage<T> {
    private let key: String
    private let userDefault: LocalStorageService
    private let defaultValue: T
    
    init(key: String, userDefault: LocalStorageService = UserDefaults.standard, defaultValue: T) {
        self.key = key
        self.userDefault = userDefault
        self.defaultValue = defaultValue
        
    }
    
    var wrappedValue: T {
        get {
            return userDefault.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefault.set(newValue, forKey: key)
        }
    }
}

protocol LocalStorageService {
    func object(forKey: String) -> Any?
    
    func set(_ value: Any?, forKey: String)
}

extension UserDefaults: LocalStorageService {

    
    
}
