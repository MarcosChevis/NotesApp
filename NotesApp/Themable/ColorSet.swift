//
//  UIColorColorSetExtension.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit
import SwiftUI

//enum ColorSet: String, CaseIterable {
//    case classic
//    case dark
//    case neon
//    case christmas
//    case grape
//    case bookish
//    case halloween
//    case devotional
//    case crt
//    case unicorn
//
//
//
//    func palette() -> CustomColorSet {
//        switch self {
//        case .neon:
//            return CustomColorSet(actionColor: UIColor(Color("NeonAction")),
//                                  background: UIColor(Color("NeonBackground")),
//                                  buttonBackground: UIColor(Color("NeonButtonBackground")),
//                                  noteBackground: UIColor(Color("NeonNoteBackground")),
//                                  text: UIColor(Color("NeonText")), largeTitle: UIColor(Color("NeonText")), statusBarStyle: .lightContent)
//        case .classic:
//            return CustomColorSet(actionColor: UIColor(Color("ClassicAction")),
//                                  background: UIColor(Color("ClassicBackground")),
//                                  buttonBackground: UIColor(Color("ClassicButtonBackground")),
//                                  noteBackground: UIColor(Color("ClassicNoteBackground")),
//                                  text: UIColor(Color("ClassicText")), largeTitle: UIColor(Color("ClassicText")), statusBarStyle: .darkContent)
//
//        case .christmas:
//            return CustomColorSet(actionColor: UIColor(Color("ChristmasAction")),
//                                  background: UIColor(Color("ChristmasBackground")),
//                                  buttonBackground: UIColor(Color("ChristmasButtonBackground")),
//                                  noteBackground: UIColor(Color("ChristmasNoteBackground")),
//                                  text: UIColor(Color("ChristmasText")), largeTitle: UIColor(Color("ChristmasLargeTitle")), statusBarStyle: .lightContent)
//
//        case .grape:
//            return CustomColorSet(actionColor: UIColor(Color("BiAction")),
//                                  background: UIColor(Color("BiBackground")),
//                                  buttonBackground: UIColor(Color("BiButtonBackground")),
//                                  noteBackground: UIColor(Color("BiNoteBackground")),
//                                  text: UIColor(Color("BiText")), largeTitle: UIColor(Color("BiLargeTitle")), statusBarStyle: .darkContent)
//
//        case .bookish:
//            return CustomColorSet(actionColor: UIColor(Color("PaulinhaAction")),
//                                  background: UIColor(Color("PaulinhaBackground")),
//                                  buttonBackground: UIColor(Color("PaulinhaButtonBackground")),
//                                  noteBackground: UIColor(Color("PaulinhaNoteBackground")),
//                                  text: UIColor(Color("PaulinhaText")), largeTitle: UIColor(Color("PaulinhaText")), statusBarStyle: .darkContent)
//        case .halloween:
//            return CustomColorSet(actionColor: UIColor(Color("HalloweenAction")),
//                                  background: UIColor(Color("HalloweenBackground")),
//                                  buttonBackground: UIColor(Color("HalloweenButtonBackground")),
//                                  noteBackground: UIColor(Color("HalloweenNoteBackground")),
//                                  text: UIColor(Color("HalloweenText")), largeTitle: UIColor(Color("HalloweenText")), statusBarStyle: .lightContent)
//        case .devotional:
//            return CustomColorSet(actionColor: UIColor(Color("SunshineAction")),
//                                  background: UIColor(Color("SunshineBackground")),
//                                  buttonBackground: UIColor(Color("SunshineButtonBackground")),
//                                  noteBackground: UIColor(Color("SunshineNoteBackground")),
//                                  text: UIColor(Color("SunshineText")), largeTitle: UIColor(Color("SunshineText")), statusBarStyle: .darkContent)
//
//        case .crt:
//            return CustomColorSet(actionColor: UIColor(Color("MatrixAction")),
//                                  background: UIColor(Color("MatrixBackground")),
//                                  buttonBackground: UIColor(Color("MatrixButtonBackground")),
//                                  noteBackground: UIColor(Color("MatrixNoteBackground")),
//                                  text: UIColor(Color("MatrixText")), largeTitle: UIColor(Color("MatrixText")), statusBarStyle: .lightContent)
//        case .dark:
//            return CustomColorSet(actionColor: UIColor(Color("SwiftDarkAction")),
//                                  background: UIColor(Color("SwiftDarkBackground")),
//                                  buttonBackground: UIColor(Color("SwiftDarkButtonBackground")),
//                                  noteBackground: UIColor(Color("SwiftDarkNoteBackground")),
//                                  text: UIColor(Color("SwiftDarkText")), largeTitle: UIColor(Color("SwiftDarkText")), statusBarStyle: .lightContent)
//        case .unicorn:
//            return CustomColorSet(actionColor: UIColor(Color("UnicornAction")),
//                                  background: UIColor(Color("UnicornBackground")),
//                                  buttonBackground: UIColor(Color("UnicornButtonBackground")),
//                                  noteBackground: UIColor(Color("UnicornNoteBackground")),
//                                  text: UIColor(Color("UnicornText")), largeTitle: UIColor(Color("UnicornLargeTitle")), statusBarStyle: .darkContent)
//
//        }
//    }
//}

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
    
    init(actionColor: UIColor? = nil, background: UIColor? = nil, buttonBackground: UIColor? = nil, noteBackground: UIColor? = nil, text: UIColor? = nil, largeTitle: UIColor? = nil, name: String, id: String, icon: String? = nil) {
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
    static var classic = ColorSet(actionColor: UIColor(hex: "#1D58D9FF"), background: UIColor(hex: "#F1F1F6FF"), buttonBackground: UIColor(hex: "#1D58D926"), noteBackground: UIColor(hex: "#FFFFFFFF"), text: UIColor(hex: "#000000FF"), largeTitle: UIColor(hex: "#000000FF"), name: "classic", id: "b4489fa5-6c2b-4515-9c35-be7e226cdbfa")
}
