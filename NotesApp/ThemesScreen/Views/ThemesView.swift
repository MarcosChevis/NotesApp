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
//            setExampleImage(palette: palette)
            setColors(palette: palette)
        }
    }
    
//    lazy var exampleImage: UIImageView = {
//        var img = UIImageView()
//        img.translatesAutoresizingMaskIntoConstraints = false
//        img.layer.shadowRadius = 4
//        img.layer.shadowOffset = CGSize(width: 2, height: 2)
//        img.layer.shadowColor = UIColor.black.cgColor
//        img.layer.shadowOpacity = 0.5
//        img.contentMode = .scaleAspectFit
//        addSubview(img)
//
//        return img
//    }()
    
    lazy var exampleView: ThemeExampleView = {
        var view = ThemeExampleView(palette: palette)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        return view
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
//        setExampleImage(palette: palette)
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
        let ratio = UIScreen.main.bounds.width/UIScreen.main.bounds.height
        
        
        NSLayoutConstraint.activate([
            exampleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            exampleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            exampleView.widthAnchor.constraint(equalTo: exampleView.heightAnchor, multiplier: ratio)])
       
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: exampleView.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150)])
    }
    
//    func setExampleImage(palette: ColorSet) {
//        switch palette {
//        case .neon:
//            exampleImage.image = UIImage(named: "NeonThemeExample")
//        case .classic:
//            exampleImage.image = UIImage(named: "ClassicThemeExample")
//        case .christmas:
//            exampleImage.image = UIImage(named: "ChristmasThemeExample")
//        case .grape:
//            exampleImage.image = UIImage(named: "GrapeThemeExample")
//        case .bookish:
//            exampleImage.image = UIImage(named: "BookishThemeExample")
//        case .halloween:
//            exampleImage.image = UIImage(named: "HalloweenThemeExample")
//        case .devotional:
//            exampleImage.image = UIImage(named: "DevotionalThemeExample")
//        case .crt:
//            exampleImage.image = UIImage(named: "CRTThemeExample")
//        }
//
//    }
}
