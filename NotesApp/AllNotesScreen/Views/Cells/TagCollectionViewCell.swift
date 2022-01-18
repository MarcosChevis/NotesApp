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
    
    private var palette: ColorSet? {
        didSet {
            setColors(palette: palette)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: TagCollectionCellViewModel) {
        self.palette = viewModel.palette
        setColors(palette: palette)
        
        tagLabel.text = viewModel.tag
    }
    
    func setColors(palette: ColorSet?) {
        guard let palette = palette else { return }

        contentView.backgroundColor = palette.palette().noteBackground
        tagLabel.textColor = palette.palette().actionColor
    }
}
