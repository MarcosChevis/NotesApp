//
//  ThemeCollectionViewCell.swift
//  NotesApp
//
//  Created by Nathalia do Valle Papst on 14/01/22.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "ThemeCollectionViewCell"
    
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
    
    lazy var themeLabel: UILabel = {
        var theme = UILabel()
        theme.translatesAutoresizingMaskIntoConstraints = false
        theme.textAlignment = .center
        theme.text = "Theme"
        if let descriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .title3)
            .withSymbolicTraits(.traitBold) {
            theme.font = UIFont(descriptor: descriptor, size: 0)
        } else {
            theme.font = .preferredFont(forTextStyle: .title3)
        }
        contentView.addSubview(theme)
        
        return theme
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupThemesViewCell(palette: ColorSet, isSelected: Bool) {
        
        setupLayers(palette: palette)
             
        if isSelected {
            didSelect()
        } else {
            didUnselect()
        }
        
        var titleText = palette.rawValue
        titleText = titleText.capitalized
        
        let colorSet = palette.palette()
        
        title.text = titleText
        title.textColor = colorSet.actionColor
        
        themeLabel.textColor = colorSet.text
        
        contentView.backgroundColor = colorSet.background
    }
    
    func setupLayers(palette: ColorSet) {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.33
        
        contentView.layer.borderColor = palette.palette().actionColor.cgColor
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            themeLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            themeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    
    //TODO: COLOCAR user DEJFRT aqui
    func didSelect() {
        contentView.layer.borderWidth = 4
        
    }
    
    func didUnselect() {
        contentView.layer.borderWidth = 0
    }
}
