//
//  UIColorColorSetExtension.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit
import SwiftUI

enum ColorSet: String, CaseIterable {
    case neon
    case classic
    case christmas
    case bi
    
    func palette() -> CustomColorSet {
        switch self {
        case .neon:
            return CustomColorSet(actionColor: UIColor(Color("NeonAction")),
                                  background: UIColor(Color("NeonBackground")),
                                  buttonBackground: UIColor(Color("NeonButtonBackground")),
                                  noteBackground: UIColor(Color("NeonNoteBackground")),
                                  text: UIColor(Color("NeonText")), largeTitle: UIColor(Color("NeonText")))
        case .classic:
            return CustomColorSet(actionColor: UIColor(Color("ClassicAction")),
                                  background: UIColor(Color("ClassicBackground")),
                                  buttonBackground: UIColor(Color("ClassicButtonBackground")),
                                  noteBackground: UIColor(Color("ClassicNoteBackground")),
                                  text: UIColor(Color("ClassicText")), largeTitle: UIColor(Color("ClassicText")))
            
        case .christmas:
            return CustomColorSet(actionColor: UIColor(Color("ChristmasAction")),
                                  background: UIColor(Color("ChristmasBackground")),
                                  buttonBackground: UIColor(Color("ChristmasButtonBackground")),
                                  noteBackground: UIColor(Color("ChristmasNoteBackground")),
                                  text: UIColor(Color("ChristmasText")), largeTitle: UIColor(Color("ChristmasLargeTitle")))
            
        case .bi:
            return CustomColorSet(actionColor: UIColor(Color("BiAction")),
                                  background: UIColor(Color("BiBackground")),
                                  buttonBackground: UIColor(Color("BiButtonBackground")),
                                  noteBackground: UIColor(Color("BiNoteBackground")),
                                  text: UIColor(Color("BiText")), largeTitle: UIColor(Color("BiLargeTitle")))
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

}
