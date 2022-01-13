//
//  SettingsViewController.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 13/01/22.
//

import UIKit

class SettingsViewController: UIViewController {
    var contentView: SettingsView
    var palette: ColorSet
    
    init(palette: ColorSet) {
        self.contentView = SettingsView(palette: palette)
        self.palette = palette
        super.init(nibName: nil, bundle: nil)
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
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
    }
}
