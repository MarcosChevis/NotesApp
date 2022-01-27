//
//  ThemeProtocol.swift
//  NotesApp
//
//  Created by Marcos Chevis on 27/01/22.
//

import Foundation
import UIKit

protocol ThemeProtocol {
    var actionColor: UIColor? { get set }
    
    var background: UIColor? { get set }
    
    var buttonBackground: UIColor? { get set }
    
    var noteBackground: UIColor? { get set }
    
    var text: UIColor? { get set }
    
    var largeTitle: UIColor? { get set }
}

extension Theme: ThemeProtocol {
    var actionColor: UIColor? {
        get {
            return UIColor.init(hex: actionColorHex ?? "")
        }
        set {
            actionColorHex = newValue?.toHex(alpha: true)
        }
    }
    
    var background: UIColor? {
        get {
            return UIColor.init(hex: backgroundHex ?? "")
        }
        set {
            backgroundHex = newValue?.toHex(alpha: true)
        }
    }
    
    var buttonBackground: UIColor? {
        get {
            return UIColor.init(hex: buttonBackgroundHex ?? "")
        }
        set {
            buttonBackgroundHex = newValue?.toHex(alpha: true)
        }
    }
    
    var noteBackground: UIColor? {
        get {
            return UIColor.init(hex: noteBackgroundHex ?? "")
        }
        set {
            noteBackgroundHex = newValue?.toHex(alpha: true)
        }
    }
    
    var text: UIColor? {
        get {
            return UIColor.init(hex: textHex ?? "")
        }
        set {
            textHex = newValue?.toHex(alpha: true)
        }
    }
    
    var largeTitle: UIColor? {
        get {
            return UIColor.init(hex: largeTitleHex ?? "")
        }
        set {
            largeTitleHex = newValue?.toHex(alpha: true)
        }
    }
    
    
}
