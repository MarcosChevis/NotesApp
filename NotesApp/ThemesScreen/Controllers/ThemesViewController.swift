//
//  ThemesViewController.swift
//  NotesApp
//
//  Created by Caroline Taus on 13/01/22.
//

import UIKit

class ThemesViewController: ThemableViewController {
    
    var themeRepository: ThemeRepositoryProtocol
    var contentView: ThemesView
    var collectionDataSource: ThemesCollectionDataSource
    weak var coordinator: AllNotesCoordinatorProtocol?
    override var palette: ColorSet {
        didSet {
            setColors(palette: palette)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    init(palette: ColorSet, collectionDataSource: ThemesCollectionDataSource, notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = .shared, themeRepository: ThemeRepositoryProtocol = ThemeRepository.shared) {
        
        self.contentView = ThemesView(palette: palette)
        self.collectionDataSource = collectionDataSource
        self.themeRepository = themeRepository
     
        
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        self.contentView.collectionView.delegate = self
        self.contentView.collectionView.dataSource = collectionDataSource
        self.contentView.delegate = self
        
        navigationItem.rightBarButtonItems = [ contentView.plusButton]
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let data = themeRepository.getAllThemes()
        collectionDataSource.setupData(data: data)
        contentView.collectionView.reloadData()
    }
    
    func setupNavigationBar() {
        title = "Themes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func changeIcon(palette: ColorSet) {
        UIApplication.shared.setAlternateIconName(palette.icon)
    }
    
    override func didChangeTheme(_ notification: Notification) {
        super.didChangeTheme(notification)
        
        changeIcon(palette: palette)
    }
    
}

extension ThemesViewController: ThemesViewProtocol {
    func didTapPlus() {
        coordinator?.navigateToCustomTheme()
    }
    
    
}
