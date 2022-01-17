//
//  ThemesViewController.swift
//  NotesApp
//
//  Created by Caroline Taus on 13/01/22.
//

import UIKit

class ThemesViewController: UIViewController {
    var palette: ColorSet {
        didSet {
            setColors(palette: palette)
        }
    }
    var contentView: ThemesView
    var collectionDataSource: ThemesCollectionDataSouce
    var settings: Settings = Settings()
    
    init(palette: ColorSet, collectionDataSource: ThemesCollectionDataSouce) {
        self.palette = palette
        self.contentView = ThemesView(palette: palette)
        self.collectionDataSource = collectionDataSource
        
        super.init(nibName: nil, bundle: nil)
        
        setColors(palette: palette)
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
    
    func setColors(palette: ColorSet) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
    }
}

extension ThemesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<collectionDataSource.data.count {
            collectionDataSource.data[index].isSelected = index == indexPath.row
            if collectionDataSource.data[index].isSelected {
                settings.theme = collectionDataSource.data[index].colorSet.rawValue
            }
        }
        collectionView.reloadData()
        
    }
    
}
