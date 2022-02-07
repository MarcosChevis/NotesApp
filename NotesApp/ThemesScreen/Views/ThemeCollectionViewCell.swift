//
//  ThemeCollectionViewCell.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 14/01/22.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "ThemeCollectionViewCell"
    
    var isStandard: Bool
    weak var delegate: ThemeCollectionViewCellDelegate?
    
    lazy var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        if let descriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .title2)
            .withSymbolicTraits(.traitBold) {
            title.font = UIFont(descriptor: descriptor, size: 0)
        } else {
            title.font = .preferredFont(forTextStyle: .title2)
        }
        contentView.addSubview(title)
        
        return title
    }()
    
    var firstSelected: Bool = false
    
    var colorSet: ColorSet?
    
    override init(frame: CGRect) {
        isStandard = true
        
        super.init(frame: frame)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        contentView.addInteraction(interaction)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupThemesViewCell(palette: ColorSet, isSelected: Bool, isStandard: Bool) {
        
        self.colorSet = palette
        
        self.isStandard = isStandard
        
        setupLayers(palette: palette)
        
        if isSelected {
            didSelect()
        } else {
            didUnselect()
        }
        
        var titleText = palette.name
        titleText = titleText.capitalized
        
        
        
        title.text = titleText
        title.textColor = palette.actionColor
        
        contentView.backgroundColor = palette.background
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colorSet = nil
    }
    
    func setupLayers(palette: ColorSet) {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.33
        
        contentView.layer.borderColor = palette.actionColor?.cgColor
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func didSelect() {
        contentView.layer.borderWidth = 4
    }
    
    func didUnselect() {
        contentView.layer.borderWidth = 0
    }
}

extension ThemeCollectionViewCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        guard !isStandard else {
            return nil
        }
        
        let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { [weak self] action in
            guard let delegate = self?.delegate, let colorSet = self?.colorSet else { return }
            delegate.didTapEdit(with: colorSet.id)
        }
        
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { [weak self] action in
            guard let delegate = self?.delegate, let colorSet = self?.colorSet else { return }
            delegate.didTapDelete(with: colorSet.id)
        }
        
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil) { _ in
            UIMenu(title: "Actions", children: [edit, delete])
        }
    }
    
    
}
