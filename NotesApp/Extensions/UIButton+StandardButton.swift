//
//  UIButton+StandardButton.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 01/02/22.
//

import UIKit

extension UIButton {
    
    convenience init(systemImage: String, action: @escaping () -> Void) {
        self.init()
        setImage(UIImage(systemName: systemImage), for: .normal)
        layer.cornerRadius = 8
        addAction(UIAction(handler: { _ in
            action()
        }), for: .touchUpInside)
    }
}
