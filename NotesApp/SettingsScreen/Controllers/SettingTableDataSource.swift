//
//  SettingTableDataSource.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 13/01/22.
//

import UIKit

class SettingTableDataSource: NSObject, UITableViewDataSource {
    var palette: ColorSet
    
    init(palette: ColorSet) {
        self.palette = palette
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier, for: indexPath) as? SettingsTableCell else {
            preconditionFailure("cell configurated improperly")
        }
        
        cell.textLabel?.text = NSLocalizedString(.themeTitle)
        cell.setupSettingsViewCell(palette: palette)
        cell.selectionStyle = .none
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }

}
