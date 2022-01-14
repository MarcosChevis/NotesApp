//
//  ThemesViewController.swift
//  NotesApp
//
//  Created by Caroline Taus on 13/01/22.
//

import UIKit

class ThemesViewController: UIViewController {
    var palette: ColorSet
    var contentView: ThemesView
    var collectionDataSource: UICollectionViewDataSource
    
    init(palette: ColorSet, collectionDataSource: UICollectionViewDataSource) {
        self.palette = palette
        self.contentView = ThemesView(palette: palette)
        self.collectionDataSource = collectionDataSource
        
        super.init(nibName: nil, bundle: nil)
        
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
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
    }
}
