//
//  ThemesView.swift
//  NotesApp
//
//  Created by Caroline Taus on 14/01/22.
//

import UIKit

class ThemesView: ThemableView {
    override var palette: ColorSet {
        didSet {
            setExampleImage(palette: palette)
            setColors(palette: palette)
        }
    }
    
    lazy var exampleImage: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 4, height: 4)
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOpacity = 0.8
        addSubview(img)
        
        return img
    }()
    
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 5, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // funcao pra dar dismiss no teclado quando scrolla pro lado na collection
        section.visibleItemsInvalidationHandler = ({ [weak self] (visibleItems, point, env) in
            self?.endEditing(false)
        })
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = collectionViewLayout
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ThemeCollectionViewCell.self, forCellWithReuseIdentifier: ThemeCollectionViewCell.identifier)
        collection.backgroundColor = .clear
        addSubview(collection)
        
        return collection
    }()

    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = Settings()) {
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        setExampleImage(palette: palette)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setColors(palette: ColorSet) {
        let colorSet = palette.palette()
        backgroundColor = colorSet.background
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            exampleImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            exampleImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -200),
            exampleImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            exampleImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)])
       
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: exampleImage.bottomAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    func setExampleImage(palette: ColorSet) {
        switch palette {
        case .neon:
            exampleImage.image = UIImage(named: "totiNeon")
        case .classic:
            exampleImage.image = UIImage(named: "toti")
        }
    }
}
