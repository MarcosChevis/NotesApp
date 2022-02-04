//
//  UIView+EndEditting.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 04/02/22.
//

import Foundation
import UIKit

extension UIView {
    func addEndEditingTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
}
