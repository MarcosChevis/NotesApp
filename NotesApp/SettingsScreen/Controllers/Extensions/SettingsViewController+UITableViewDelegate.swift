//
//  SettingsViewController+UITableViewDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ThemesViewController(palette: palette, collectionDataSource: ThemesCollectionDataSouce()), animated: true)
        
    }
}
