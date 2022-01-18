//
//  SettingsViewController.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 13/01/22.
//

import UIKit

class SettingsViewController: UIViewController {
    var contentView: SettingsView
    var palette: ColorSet {
        didSet {
            setColors(palette: palette)
        }
    }
    var tableDateSource: SettingTableDataSource
    
    init(palette: ColorSet, tableDataSource: SettingTableDataSource) {
        self.contentView = SettingsView(palette: palette)
        self.palette = palette
        self.tableDateSource = tableDataSource
        
        super.init(nibName: nil, bundle: nil)
        
        setColors(palette: palette)
        self.contentView.tableView.dataSource = tableDataSource
        self.contentView.tableView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setColors(palette: ColorSet) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ThemesViewController(palette: palette, collectionDataSource: ThemesCollectionDataSouce()), animated: true)
        
    }
}
