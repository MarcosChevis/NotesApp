//
//  ThemesView.swift
//  NotesApp
//
//  Created by Caroline Taus on 14/01/22.
//

import UIKit

class ThemesView: ThemableView {
    
    weak var delegate: ThemesViewProtocol?
    
    override var palette: ColorSet {
        didSet {
            setColors(palette: palette)
        }
    }
    
    lazy var exampleView: ThemeExampleView = {
        var view = ThemeExampleView(palette: palette)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        return view
    }()
    
    lazy var plusButton: UIBarButtonItem = {
        let but = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain , target: self, action: #selector(didTapPlus))
        return but
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
        let layout = collectionViewLayout
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
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setColors(palette: ColorSet) {
        
        backgroundColor = palette.background
    }
    
    func setupConstraints() {
        let ratio = UIScreen.main.bounds.width/UIScreen.main.bounds.height
        
        
        NSLayoutConstraint.activate([
            exampleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            exampleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            exampleView.widthAnchor.constraint(equalTo: exampleView.heightAnchor, multiplier: ratio)
        ])
       
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: exampleView.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150)])
    }
    
    @objc func didTapPlus() {
        delegate?.didTapPlus()
    }
}
