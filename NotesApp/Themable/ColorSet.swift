//
//  UIColorColorSetExtension.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit

struct ColorSet: Equatable {
    
    let actionColor: UIColor?
    
    let background: UIColor?
    
    let buttonBackground: UIColor?
    
    let noteBackground: UIColor?
    
    let text: UIColor?
    
    let largeTitle: UIColor?
    
    var statusBarStyle: UIStatusBarStyle {
        
        guard let background = background else {
            return .default
        }

        if background.isLight() {
            return .darkContent
        } else {
            return .lightContent
        }
    }
    
    let name: String
    
    let id: String
    
    let icon: String?
    
    init(actionColor: UIColor? = nil,
         background: UIColor? = nil,
         buttonBackground: UIColor? = nil,
         noteBackground: UIColor? = nil,
         text: UIColor? = nil,
         largeTitle: UIColor? = nil,
         name: String,
         id: String,
         icon: String? = nil) {
        self.actionColor = actionColor
        self.background = background
        self.buttonBackground = buttonBackground
        self.noteBackground = noteBackground
        self.text = text
        self.largeTitle = largeTitle
        self.name = name
        self.id = id
        self.icon = icon
    }
    
    
    init(theme: ThemeProtocol) {
        actionColor = theme.actionColor
        background = theme.background
        buttonBackground = theme.buttonBackground
        noteBackground = theme.noteBackground
        text = theme.text
        largeTitle = theme.largeTitle
        name = theme.name ?? ""
        id = theme.id?.uuidString ?? ""
        self.icon = nil
    }
    
    init(theme: StandardTheme) {
        actionColor = UIColor.init(hex: theme.actionColor)
        background = UIColor.init(hex: theme.background)
        buttonBackground = UIColor.init(hex: theme.buttonBackground)
        noteBackground = UIColor.init(hex: theme.noteBackground)
        text = UIColor.init(hex: theme.text)
        largeTitle = UIColor.init(hex: theme.largeTitle)
        name = theme.name
        id = theme.id
        self.icon = theme.icon
    }

}


extension ColorSet {
    static var classic = ColorSet(actionColor: UIColor(hex: "#1D58D9FF"),
                                  background: UIColor(hex: "#F1F1F6FF"),
                                  buttonBackground: UIColor(hex: "#1D58D926"),
                                  noteBackground: UIColor(hex: "#FFFFFFFF"),
                                  text: UIColor(hex: "#000000FF"),
                                  largeTitle: UIColor(hex: "#000000FF"),
                                  name: "classic",
                                  id: "b4489fa5-6c2b-4515-9c35-be7e226cdbfa")
}
