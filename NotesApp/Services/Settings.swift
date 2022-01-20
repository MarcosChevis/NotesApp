//
//  UserDefaultManager.swift
//  NotesApp
//
//  Created by Marcos Chevis on 17/01/22.
//

import Foundation

class Settings {
    private let localStorageService: LocalStorageService
    private let notificationService: NotificationService
    
    init(localStorageService: LocalStorageService = UserDefaults.standard, notificationService: NotificationService = NotificationCenter.default) {
        self.localStorageService = localStorageService
        self.notificationService = notificationService
    }
    
    func changeTheme(palette: ColorSet) {
        theme = palette
        notificationService.post(name: .didChangeTheme, object: palette)
        
    }
    
    var theme: ColorSet {
        get {
            if let cachedTheme = cachedTheme {
                return cachedTheme
            }
            
            let colorSet = ColorSet(rawValue: localStorageService.string(forKey: "theme") ?? ColorSet.classic.rawValue) ?? .classic
            cachedTheme = colorSet
            
            return colorSet
        }
        set {
            localStorageService.set(newValue.rawValue, forKey: "theme")
            cachedTheme = nil
        }
    }
    
    private var cachedTheme: ColorSet?
    
}
