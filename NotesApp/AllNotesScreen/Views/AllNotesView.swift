//
//  AllNotesView.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import Foundation
import UIKit

class AllNotesView: UIView {
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [ item ])
        group.edgeSpacing = .init(leading: .fixed(0), top: .fixed(0), trailing: .fixed(0), bottom: .fixed(8))
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        let section = NSCollectionLayoutSection(group: group)
        //section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 18.0, bottom: 0.0, trailing: 18.0)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var settingsButton: UIBarButtonItem = {
        var but = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(didTapSettings))
        return but
    }()
    
    lazy var addNoteButton: UIBarButtonItem = {
        var but = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddNote))
        return but
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    lazy var collectionView: UICollectionView = {
        var layout = collectionViewLayout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.backgroundColor = .secondarySystemBackground
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NoteSmallCellCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    weak var delegate: NoteSmallCellCollectionViewCellDelegate?
    
    var palette: ColorSet
    
    init(palette: ColorSet) {
        self.palette = palette
        super.init(frame: .zero)
        self.backgroundColor = palette.palette().background
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
//            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//        ])
    }
    
    @objc func didTapSettings() {
        print("settings")
    }
    
    @objc func didTapAddNote() {
        print("mais")
    }
}
