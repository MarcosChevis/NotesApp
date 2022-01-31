//
//  UIColor+isLight.swift
//  NotesApp
//
//  Created by Marcos Chevis on 28/01/22.
//

import Foundation
import UIKit

// returns true if color is light, false if it is dark
extension UIColor {
    func isLight() -> Bool {
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        guard let components = cgColor.components else { return false }
        
        let brightness: CGFloat = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000

        if brightness < 0.5 {
            return false
        }
        else {
            return true
        }
    }
}
