//
//  NoteView.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit

class NoteView: UIView {
    
    lazy var shareButton: UIBarButtonItem = {
        var but = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(didTapShare))
        
        return but
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewLayout()
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collection)
        
        collection.backgroundColor = .red
        
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
    
}
