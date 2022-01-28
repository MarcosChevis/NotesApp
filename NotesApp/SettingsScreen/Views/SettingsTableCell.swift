//
//  SettingsTableCell.swift
//  NotesApp
//
//  Created by Marcos Chevis on 17/01/22.
//

import Foundation
import UIKit

class SettingsTableCell: UITableViewCell {
    static var identifier: String = "SettingsTableCell"
    var palette: CustomColorSet? {
        didSet {
            setColors(palette: palette)
        }
    }
    
    func setupSettingsViewCell(palette: CustomColorSet) {
        self.palette = palette
        self.layer.cornerRadius = 10
    }
    
    func setColors(palette: CustomColorSet?) {
        guard let palette = palette else { return }
        
        backgroundColor = palette.noteBackground
        textLabel?.textColor = palette.text
    }
    
    
}
