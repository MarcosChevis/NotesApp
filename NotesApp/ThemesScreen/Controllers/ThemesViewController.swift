//
//  ThemesViewController.swift
//  NotesApp
//
//  Created by Caroline Taus on 13/01/22.
//

import UIKit

class ThemesViewController: ThemableViewController {
    
    var contentView: ThemesView
    var collectionDataSource: ThemesCollectionDataSouce
    weak var coordinator: AllNotesCoordinatorProtocol?
    override var palette: ColorSet {
        didSet {
            setColors(palette: palette)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    init(palette: ColorSet, collectionDataSource: ThemesCollectionDataSouce, notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = Settings()) {
        
        self.contentView = ThemesView(palette: palette)
        self.collectionDataSource = collectionDataSource
     
        
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        self.contentView.collectionView.delegate = self
        self.contentView.collectionView.dataSource = collectionDataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
    }
    
    func setupNavigationBar() {
        title = "Themes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func changeIcon(palette: ColorSet) {
        switch palette {
        case .classic:
            UIApplication.shared.setAlternateIconName(nil)
        case .dark:
            UIApplication.shared.setAlternateIconName("DarkTheme")
        case .neon:
            UIApplication.shared.setAlternateIconName("NeonTheme")
        case .christmas:
            UIApplication.shared.setAlternateIconName("ChristmasTheme")
        case .grape:
            UIApplication.shared.setAlternateIconName("GrapeTheme")
        case .bookish:
            UIApplication.shared.setAlternateIconName("BookishTheme")
        case .halloween:
            UIApplication.shared.setAlternateIconName("HalloweenTheme")
        case .devotional:
            UIApplication.shared.setAlternateIconName("DevotionalTheme")
        case .crt:
            UIApplication.shared.setAlternateIconName("MatrixTheme")
        case .unicorn:
            UIApplication.shared.setAlternateIconName("UnicornTheme")
        }
    }
    
    override func didChangeTheme(_ notification: Notification) {
        super.didChangeTheme(notification)
        
        changeIcon(palette: palette)
    }
    
}
