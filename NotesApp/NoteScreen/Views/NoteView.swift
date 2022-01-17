//
//  NoteView.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit
import CoreData

class NoteView: UIView {
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 5, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0)
        
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
        collection.backgroundColor = .secondarySystemBackground
        collection.isScrollEnabled = false
        backgroundColor = .secondarySystemBackground
        
        return collection
    }()
    
    weak var delegate: NoteViewDelegate?
    
    
    var pallete: ColorSet
    
    init(palette: ColorSet) {
        self.pallete = palette
        
        super.init(frame: .zero)
        
        self.backgroundColor = palette.palette().background
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            let result = Int((point.x + cellCenter) / (cellWidth - 24))
            let indexPath = IndexPath(item: result, section: 0)
            return indexPath
        } else {
            return nil
        }
    }
    
}


