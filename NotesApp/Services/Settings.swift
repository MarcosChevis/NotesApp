//
//  UserDefaultManager.swift
//  NotesApp
//
//  Created by Marcos Chevis on 17/01/22.
//

import Foundation

class Settings {
    private let themeKey = "themeKey"
    
    private let localStorageService: LocalStorageService
    private let notificationService: NotificationService
    private let themeRepository: ThemeRepositoryProtocol
    
    static var shared = Settings()
    
    init(localStorageService: LocalStorageService = UserDefaults.standard, notificationService: NotificationService = NotificationCenter.default, themeRepository: ThemeRepositoryProtocol = ThemeRepository.shared) {
        self.localStorageService = localStorageService
        self.notificationService = notificationService
        self.themeRepository = themeRepository
        
}
    
    func changeTheme(palette: ColorSet) {
        theme = palette
        notificationService.post(name: .didChangeTheme, object: palette)
    }
    
    var theme: ColorSet {
        get {
            guard let id = localStorageService.string(forKey: themeKey) else {
                return .classic
            }
            guard let theme = themeRepository.getTheme(with: id) else {
                return .classic
            }
            return theme
        }
        set {
            localStorageService.set(newValue.id, forKey: themeKey)
        }
    }
}
