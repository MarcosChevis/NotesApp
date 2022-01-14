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
        contentView.addSubview(title)
        
        return title
    }()
    
    lazy var themeLabel: UILabel = {
        var theme = UILabel()
        theme.translatesAutoresizingMaskIntoConstraints = false
        theme.textAlignment = .center
        theme.text = "Theme"
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
    
    func setupThemesViewCell(palette: ColorSet) {
        title.text = palette.rawValue
        title.textColor = palette.palette().actionColor
        
        themeLabel.textColor = palette.palette().text
        
        contentView.backgroundColor = palette.palette().background
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
}
