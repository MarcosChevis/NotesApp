//
//  AllNotesView.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import Foundation
import UIKit

class AllNotesView: ThemableView {
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [ item ])
        group.edgeSpacing = .init(leading: .fixed(0), top: .fixed(0), trailing: .fixed(0), bottom: .fixed(8))
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var settingsButton: UIBarButtonItem = {
        let but = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain , target: self, action: #selector(didTapSettings))
        return but
    }()
    
    lazy var closeButton: UIBarButtonItem = {
        let but = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(didTapClose))
        return but
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NoteSmallCellCollectionViewCell.self, forCellWithReuseIdentifier: NoteSmallCellCollectionViewCell.identifier)
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier)
        
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return Self.tagSection
            case 1:
                return Self.notesSection
            default:
                return Self.notesSection
            }
        }
        
        return layout
    }()
    
    static var notesSection: NSCollectionLayoutSection = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: .fixed(0), top: .fixed(0), trailing: .fixed(0), bottom: .fixed(8))
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }()
    
    static var tagSection: NSCollectionLayoutSection = {
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .estimated(60))
        //3
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.edgeSpacing = .init(leading: .fixed(0), top: .fixed(0), trailing: .fixed(0), bottom: .fixed(8))
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 0)
        section.boundarySupplementaryItems = [header]
        return section
    }()
    
    weak var delegate: AllNotesViewDelegate?
    
    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = Settings()) {
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setColors(palette: ColorSet) {
        let colorSet = palette.palette()
        self.backgroundColor = colorSet.background
        collectionView.backgroundColor = colorSet.background
        searchController.searchBar.tintColor = colorSet.actionColor
        searchController.searchBar.searchTextField.backgroundColor = colorSet.noteBackground.withAlphaComponent(0.6)
        switch colorSet.statusBarStyle {
            
        case .default:
            searchController.searchBar.barStyle = .default
        case .lightContent:
            searchController.searchBar.barStyle = .black
        case .darkContent:
            searchController.searchBar.barStyle = .default
        @unknown default:
            searchController.searchBar.barStyle = .default
        }
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    @objc func didTapSettings() {
        delegate?.didTapSettings()
    }
    
    @objc func didTapClose() {
        delegate?.didTapClose()
    }
}
