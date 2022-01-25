//
//  UIColorColorSetExtension.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit
import SwiftUI

enum ColorSet: String, CaseIterable {
    case classic
    case neon
    case christmas
    case grape
    case bookish
    case halloween
    case devotional
    case crt
    case dark
    
    func palette() -> CustomColorSet {
        switch self {
        case .neon:
            return CustomColorSet(actionColor: UIColor(Color("NeonAction")),
                                  background: UIColor(Color("NeonBackground")),
                                  buttonBackground: UIColor(Color("NeonButtonBackground")),
                                  noteBackground: UIColor(Color("NeonNoteBackground")),
                                  text: UIColor(Color("NeonText")), largeTitle: UIColor(Color("NeonText")), statusBarStyle: .lightContent)
        case .classic:
            return CustomColorSet(actionColor: UIColor(Color("ClassicAction")),
                                  background: UIColor(Color("ClassicBackground")),
                                  buttonBackground: UIColor(Color("ClassicButtonBackground")),
                                  noteBackground: UIColor(Color("ClassicNoteBackground")),
                                  text: UIColor(Color("ClassicText")), largeTitle: UIColor(Color("ClassicText")), statusBarStyle: .darkContent)
            
        case .christmas:
            return CustomColorSet(actionColor: UIColor(Color("ChristmasAction")),
                                  background: UIColor(Color("ChristmasBackground")),
                                  buttonBackground: UIColor(Color("ChristmasButtonBackground")),
                                  noteBackground: UIColor(Color("ChristmasNoteBackground")),
                                  text: UIColor(Color("ChristmasText")), largeTitle: UIColor(Color("ChristmasLargeTitle")), statusBarStyle: .lightContent)
            
        case .grape:
            return CustomColorSet(actionColor: UIColor(Color("BiAction")),
                                  background: UIColor(Color("BiBackground")),
                                  buttonBackground: UIColor(Color("BiButtonBackground")),
                                  noteBackground: UIColor(Color("BiNoteBackground")),
                                  text: UIColor(Color("BiText")), largeTitle: UIColor(Color("BiLargeTitle")), statusBarStyle: .darkContent)
            
        case .bookish:
            return CustomColorSet(actionColor: UIColor(Color("PaulinhaAction")),
                                  background: UIColor(Color("PaulinhaBackground")),
                                  buttonBackground: UIColor(Color("PaulinhaButtonBackground")),
                                  noteBackground: UIColor(Color("PaulinhaNoteBackground")),
                                  text: UIColor(Color("PaulinhaText")), largeTitle: UIColor(Color("PaulinhaText")), statusBarStyle: .darkContent)
        case .halloween:
            return CustomColorSet(actionColor: UIColor(Color("HalloweenAction")),
                                  background: UIColor(Color("HalloweenBackground")),
                                  buttonBackground: UIColor(Color("HalloweenButtonBackground")),
                                  noteBackground: UIColor(Color("HalloweenNoteBackground")),
                                  text: UIColor(Color("HalloweenText")), largeTitle: UIColor(Color("HalloweenText")), statusBarStyle: .lightContent)
        case .devotional:
            return CustomColorSet(actionColor: UIColor(Color("SunshineAction")),
                                  background: UIColor(Color("SunshineBackground")),
                                  buttonBackground: UIColor(Color("SunshineButtonBackground")),
                                  noteBackground: UIColor(Color("SunshineNoteBackground")),
                                  text: UIColor(Color("SunshineText")), largeTitle: UIColor(Color("SunshineText")), statusBarStyle: .darkContent)
            
        case .crt:
            return CustomColorSet(actionColor: UIColor(Color("MatrixAction")),
                                  background: UIColor(Color("MatrixBackground")),
                                  buttonBackground: UIColor(Color("MatrixButtonBackground")),
                                  noteBackground: UIColor(Color("MatrixNoteBackground")),
                                  text: UIColor(Color("MatrixText")), largeTitle: UIColor(Color("MatrixText")), statusBarStyle: .lightContent)
        case .dark:
            return CustomColorSet(actionColor: UIColor(Color("SwiftDarkAction")),
                                  background: UIColor(Color("SwiftDarkBackground")),
                                  buttonBackground: UIColor(Color("SwiftDarkButtonBackground")),
                                  noteBackground: UIColor(Color("SwiftDarkNoteBackground")),
                                  text: UIColor(Color("SwiftDarkText")), largeTitle: UIColor(Color("SwiftDarkText")), statusBarStyle: .lightContent)
        }
    }
}

struct CustomColorSet: Equatable {
    var actionColor: UIColor
    
    var background: UIColor
    
    var buttonBackground: UIColor
    
    var noteBackground: UIColor
    
    var text: UIColor
    
    var largeTitle: UIColor
    
    var statusBarStyle: UIStatusBarStyle

}
