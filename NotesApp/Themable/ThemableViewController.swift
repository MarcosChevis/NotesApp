//
//  ThemableViewController.swift
//  NotesApp
//
//  Created by Caroline Taus on 18/01/22.
//

import Foundation
import UIKit

class ThemableViewController: UIViewController {
    var palette: ColorSet{
        didSet {
            setColors(palette: palette)
        }
    }
    let notificationService: NotificationService
    let settings: Settings
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return palette.palette().statusBarStyle
    }
    
    init(palette: ColorSet, notificationService: NotificationService,
         settings: Settings) {
        self.settings = settings
        self.notificationService = notificationService
        self.palette = palette
        super.init(nibName: nil, bundle: nil)
        
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        notificationService.removeObserver(self)
    }
    
    func setupBindings() {
        notificationService.addObserver(self, selector: #selector(didChangeTheme), name: .didChangeTheme, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setColors(palette: palette)
    }
    
    @objc func didChangeTheme(_ notification: Notification) {
        guard let palette = notification.object as? ColorSet else { return }
        self.palette = palette
    }
    
    func setColors(palette: ColorSet) {
        let colorSet = palette.palette()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: colorSet.largeTitle]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: colorSet.largeTitle]
        navigationController?.navigationBar.tintColor = colorSet.actionColor
        navigationController?.navigationBar.barTintColor = colorSet.background
        
    }
    
    
    
}
