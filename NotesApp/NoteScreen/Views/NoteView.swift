//
//  NoteView.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit
import CoreData

class NoteView: ThemableView {
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.88), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // funcao pra dar dismiss no teclado quando scrolla pro lado na collection
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, point, env) in
            guard let self = self else { return }
            self.endEditing(false)
            
            self.delegate?.collectionDidShowCells(of: visibleItems.map(\.indexPath))
            
            if let indexPath = self.findCurrentCellIndexPath(for: point) {
                self.delegate?.collectionViewDidMove(to: indexPath)
            }
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var addButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddNote))
    }()
    
    lazy var allNotesButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "menucard"), style: .plain , target: self, action: #selector(didTapAllNotes))
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = collectionViewLayout
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collection)
        collection.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identifier)
        collection.backgroundColor = .clear
        collection.isScrollEnabled = false
        
        return collection
    }()
    
    weak var delegate: NoteViewDelegate?
    
    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
                  settings: Settings = .shared) {
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setColors(palette: ColorSet) {
        
        backgroundColor = palette.background
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    @objc func didTapAllNotes() {
        delegate?.didAllNotes()
        
    }
    
    @objc func didTapAddNote() {
        delegate?.didAdd()
    }
    
    private func findCurrentCellIndexPath(for point: CGPoint) -> IndexPath? {
        if let layout = collectionView.layoutAttributesForItem(at: IndexPath(item: 0, section: 0)) {
            let cellWidth = layout.bounds.width
            let doubleResult = (point.x + 20 + (0.05*cellWidth)) / (cellWidth+10)
            let result = Int(round(doubleResult))
            let indexPath = IndexPath(item: result, section: 0)
            return indexPath
        } else {
            return nil
        }
    }
    
}


