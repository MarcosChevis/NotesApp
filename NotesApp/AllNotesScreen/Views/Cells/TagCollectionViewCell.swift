//
//  TagCollectionViewCell.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 13/01/22.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "AllNotes.TagCollectionViewCell"
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(label)
        
        let constraints: [NSLayoutConstraint] = [
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ]
        NSLayoutConstraint.activate(constraints)
        return label
    }()
    
    private let palette: CustomColorSet?
    
    override init(frame: CGRect) {
        palette = nil
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: TagCollectionCellViewModel) {
        let newPalette = viewModel.colorSet.palette()
        if shouldUpdateColors(newPalette) {
            updateColors(with: newPalette)
        }
        tagLabel.text = viewModel.tag
    }
    
    func shouldUpdateColors(_ palette: CustomColorSet) -> Bool {
        guard
            let currentPalette = self.palette,
            currentPalette == palette
        else {
            return true
        }
        return false
    }
    
    func updateColors(with palette: CustomColorSet) {
        contentView.backgroundColor = palette.noteBackground
        tagLabel.textColor = palette.actionColor
    }
}
