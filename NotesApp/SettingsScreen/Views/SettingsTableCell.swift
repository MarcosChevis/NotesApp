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
            backgroundColor = palette?.palette().noteBackground
            textLabel?.textColor = palette?.palette().text

        }
    }
    
    func setupSettingsViewCell(palette: ColorSet) {
        self.palette = palette
    }
    
    
}
