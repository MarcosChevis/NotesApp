//
//  SettingTableDataSource.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 13/01/22.
//

import UIKit

class SettingTableDataSource: NSObject, UITableViewDataSource {
    var palette: ColorSet = ColorSet.neon
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Themes"
        cell.textLabel?.textColor = palette.palette().text
        cell.backgroundColor = palette.palette().noteBackground
        cell.selectionStyle = .none
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }

}
