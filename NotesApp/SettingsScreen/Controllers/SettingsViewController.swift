//
//  SettingsViewController.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 13/01/22.
//

import UIKit

class SettingsViewController: ThemableViewController {
    var contentView: SettingsView
    weak var coordinator: AllNotesCoordinatorProtocol?
    var tableDataSource: SettingTableDataSource
    
    init(palette: ColorSet, tableDataSource: SettingTableDataSource, notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = Settings()) {
        self.contentView = SettingsView(palette: palette)
        self.tableDataSource = tableDataSource
        
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        
        
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
    
    override func setColors(palette: ColorSet) {
        super.setColors(palette: palette)
        
        tableDataSource.palette = palette
        contentView.tableView.reloadData()
    }
    
}
