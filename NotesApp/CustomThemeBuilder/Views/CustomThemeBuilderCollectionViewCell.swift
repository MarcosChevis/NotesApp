//
//  CustomThemeBuilderCollectionViewCell.swift
//  NotesApp
//
//  Created by Marcos Chevis on 26/01/22.
//

import UIKit
import SwiftUI

class CustomThemeBuilderCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "CustomThemeBuilderCollectionViewCell"
    var palette: CustomColorSet?
    
    lazy var builderContentView: CustomThemeBuilderCollectionViewCellContentView = {
        
        var view = CustomThemeBuilderCollectionViewCellContentView(palette: palette ?? CustomColorSet.classic)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    func setupCell(color: UIColor?, colorName: String, palette: CustomColorSet) {
        setupHierarchy()
        setupConstraints()
        self.builderContentView.palette = palette
        self.builderContentView.colorNameLabel.text = colorName
        setupCellColor(color: color)
    }
    
    func setupCellColor(color: UIColor?) {
        self.builderContentView.colorView.backgroundColor = color
    }
    
    func setupHierarchy() {
        contentView.addSubview(builderContentView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            builderContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            builderContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            builderContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            builderContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
   
    
}
