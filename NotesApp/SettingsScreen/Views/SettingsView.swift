//
//  SettingsView.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 13/01/22.
//

import UIKit

class SettingsView: UIView {
    var palette: ColorSet {
        didSet {
            setColors(palette: palette)
        }
    }
    
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.backgroundColor = .clear
        
        table.register(SettingsTableCell.self, forCellReuseIdentifier: SettingsTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        addSubview(table)
        
        return table
    }()
    
    init(palette: ColorSet) {
        self.palette = palette
        super.init(frame: .zero)
        setColors(palette: palette)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColors(palette: ColorSet) {
        self.backgroundColor = palette.palette().background
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
