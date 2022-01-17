//
//  TagCollectionViewCell.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 13/01/22.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(label)
        
        let constraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -8)
        ]
        return label
    }()
    
    private var palette: ColorSet? {
        didSet {
            setColors(palette: palette)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: TagCollectionCellViewModel, palette: ColorSet) {
        self.palette = palette
        setColors(palette: palette)
        
        tagLabel.text = viewModel.tag
    }
    
    func setColors(palette: ColorSet?) {
        guard let palette = palette else { return }

        contentView.backgroundColor = palette.palette().noteBackground
        tagLabel.textColor = palette.palette().actionColor
    }
}
