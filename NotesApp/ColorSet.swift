//
//  UIColorColorSetExtension.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit
import SwiftUI

enum ColorSets: String {
    case neon
    case classic
    
    func palette() -> CustomColorSet {
        switch self {
        case .neon:
            return CustomColorSet(actionColor: UIColor(Color("NeonAction")),
                                  background: UIColor(Color("NeonBackground")),
                                  buttonBackground: UIColor(Color("NeonButtonBackground")),
                                  noteBackground: UIColor(Color("NeonNoteBakground")),
                                  text: UIColor(Color("NeonText")))
        case .classic:
            return CustomColorSet(actionColor: UIColor(Color("ClassicAction")),
                                  background: UIColor(Color("ClassicBackground")),
                                  buttonBackground: UIColor(Color("ClassicButtonBackground")),
                                  noteBackground: UIColor(Color("ClassicNoteBakground")),
                                  text: UIColor(Color("ClassicText")))
        }
    }
}

//class NeonColorSet: CustomColorSet {
//    var actionColor: UIColor = UIColor(named: "NeonAction")!
//
//    var background: UIColor = UIColor(named: "NeonBackground")!
//
//    var buttonBackground: UIColor = UIColor(named: "NeonButtonBackground")!
//
//    var noteBackground: UIColor = UIColor(named: "NeonBackground")!
//
//    var textColor: UIColor = UIColor(named: "NeonText")!
//
//}
//
//
//}

struct CustomColorSet {
    var actionColor: UIColor
    
    var background: UIColor
    
    var buttonBackground: UIColor
    
    var noteBackground: UIColor
    
    var text: UIColor

}
