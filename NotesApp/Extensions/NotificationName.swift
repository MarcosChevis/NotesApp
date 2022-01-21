//
//  NotificationName.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 17/01/22.
//

import Foundation

extension Notification.Name {
    static var saveChanges: Self {
        .init(rawValue: "NoteCell_DidFinishSaving")
    }
    static var didChangeTheme: Self {
        .init(rawValue: "ThemeManager_DidChangeTheme")
    }
    
    static var didComebackFromModal: Self {
        .init(rawValue: "AllNotesCoordinator_DidComebackFromModal")
    }
}
