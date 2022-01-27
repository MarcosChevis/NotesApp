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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.99))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        
        // funcao pra dar dismiss no teclado quando scrolla pro lado na collection
        section.visibleItemsInvalidationHandler = ({ [weak self] (visibleItems, point, env) in
            guard let self = self else { return }
            
            self.endEditing(false)
            
            if let indexPath = self.findCurrentCellIndexPath(for: point) {
                self.delegate?.collectionViewDidMove(to: indexPath)
            }
        })
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var shareButton: UIBarButtonItem = {
        var but = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(didTapShare))
        
        return but
    }()
    
    lazy var toolbarItems: [UIBarButtonItem] = {
        var items = [UIBarButtonItem]()
        
        items.append( UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete)))
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append( UIBarButtonItem(image: UIImage(systemName: "note.text"), style: .plain , target: self, action: #selector(didTapAllNotes)))
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append( UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddNote)))
        
        return items
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = collectionViewLayout
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
         settings: Settings = Settings()) {
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setColors(palette: ColorSet) {
        let colorSet = palette.palette()
        backgroundColor = colorSet.background
        
        for item in toolbarItems {
            item.tintColor = colorSet.actionColor
        }
    }
    
    func setupConstraints() {
        
        //CollectionView Constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc func didTapShare() {
        delegate?.didShare()
    }
    
    @objc func didTapDelete() {
        delegate?.didDelete()
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
            let cellCenter = cellWidth/2
            let doubleResult = (point.x + cellCenter+20+(0.08*cellWidth)) / (cellWidth+10)
            let result = Int(doubleResult)
            let indexPath = IndexPath(item: result, section: 0)
            return indexPath
        } else {
            return nil
        }
    }
    
}


