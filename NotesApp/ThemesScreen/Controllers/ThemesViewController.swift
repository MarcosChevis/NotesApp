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
        self.collectionDataSource.cellDelegate = self
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
                
        setupDataSource()
    }
    
    func setupNavigationBar() {
        title = NSLocalizedString(.themeTitle)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func changeIcon(palette: ColorSet) {
        UIApplication.shared.setAlternateIconName(palette.icon)
    }
    
    override func didChangeTheme(_ notification: Notification) {
        super.didChangeTheme(notification)
        
        changeIcon(palette: palette)
    }
    
    func setupDataSource() {
        let data = themeRepository.getAllColorSets()
        collectionDataSource.setupData(data: data)
        contentView.collectionView.reloadData()
    }

}

extension ThemesViewController: ThemesViewProtocol {
    func didTapPlus() {
        coordinator?.navigateToCustomTheme()
    }
    
}

extension ThemesViewController: ThemeCollectionViewCellDelegate {
    func didTapEdit(with id: String) {
        coordinator?.editCustomTheme(with: id)
    }
    
    func didTapDelete(with id: String) {
        do {
            try themeRepository.deleteTheme(with: id)
            setupDataSource()
            settings.changeTheme(palette: collectionDataSource.data[0].colorSet)
            collectionDataSource.data[0].isSelected = true
            contentView.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        } catch {
            coordinator?.presentErrorAlert(with: NSLocalizedString(.alertError))
        }
    }
}
