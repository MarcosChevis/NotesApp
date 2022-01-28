//
//  CustomThemeBuilderView.swift
//  NotesApp
//
//  Created by Marcos Chevis on 26/01/22.
//

import UIKit

class CustomThemeBuilderView: ThemableView {
    
    weak var delegate: CustomThemeBuilderViewDelegate?
    private var placeholder: NSMutableAttributedString
    private var placeholderContent: String = "Your theme name here"
    
    lazy var cancelButton: UIBarButtonItem = {
        let but = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        return but
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let but = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        
        return but
    }()
    
    lazy var themeNameTextView: UITextField = {
        let textView = UITextField(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.font = UIFont.boldSystemFont(ofSize: 34)
        
        
        
        return textView
    }()
    
    lazy var exampleView: ThemeExampleView = {
        var view = ThemeExampleView(palette: palette)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = collectionViewLayout
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CustomThemeBuilderCollectionViewCell.self, forCellWithReuseIdentifier: CustomThemeBuilderCollectionViewCell.identifier)
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 5, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .groupPaging
        
        // funcao pra dar dismiss no teclado quando scrolla pro lado na collection
        section.visibleItemsInvalidationHandler = ({ [weak self] (visibleItems, point, env) in
            self?.endEditing(false)
        })
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()

    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
                  settings: Settings = .shared) {
        
        self.placeholder = .init(string: placeholderContent)
        
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupHierarchy() {
        addSubview(themeNameTextView)
        addSubview(exampleView)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        let ratio = UIScreen.main.bounds.width/UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            themeNameTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            themeNameTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            themeNameTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            exampleView.topAnchor.constraint(equalTo: themeNameTextView.bottomAnchor, constant: 16),
            exampleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            exampleView.widthAnchor.constraint(equalTo: exampleView.heightAnchor, multiplier: ratio)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: exampleView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func didTapSave() {
        delegate?.didTapSave()
    }
    
    @objc func didTapCancel() {
        delegate?.didTapCancel()
    }
    
    override func setColors(palette: ColorSet) {
        super.setColors(palette: palette)
        
        backgroundColor = palette.background
        saveButton.tintColor = palette.actionColor
        cancelButton.tintColor = palette.actionColor
        
        guard let textColor = palette.text?.withAlphaComponent(0.4) else { return }
        
        let attributeRange = NSRange(location: 0, length: placeholderContent.count)
        placeholder.removeAttribute(NSAttributedString.Key.foregroundColor, range: attributeRange)
        placeholder.addAttributes([NSAttributedString.Key.foregroundColor: textColor], range: attributeRange)
    }
}
