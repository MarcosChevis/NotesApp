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
    var palette: ColorSet? {
        didSet {
            setColors(palette: palette)

        }
    }
    
    func setupSettingsViewCell(palette: ColorSet) {
        self.palette = palette
    }
    
    func setColors(palette: ColorSet?) {
        guard let colorSet = palette?.palette() else { return }
        
        backgroundColor = colorSet.noteBackground
        textLabel?.textColor = colorSet.text
    }
    
    
}
