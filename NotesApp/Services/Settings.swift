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
            ColorSet(rawValue: localStorageService.string(forKey: "theme") ?? ColorSet.classic.rawValue) ?? .classic
        }
        set {
            localStorageService.set(newValue.rawValue, forKey: "theme")
        }
    }
    
    private var cachedTheme: ColorSet?
    
}
