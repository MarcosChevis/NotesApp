//
//  ThemesCollectionViewCell.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import Foundation
import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    var title: UITextField = {
        var title = UITextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        if let descriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .title2)
            .withSymbolicTraits(.traitBold) {
            title.font = UIFont(descriptor: descriptor, size: 0)
        } else {
            title.font = .preferredFont(forTextStyle: .title2)
        }
        
        title.textAlignment = .left
        return title
    }()
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()
    
    var palette: ColorSet? {
        didSet {
            setColors(palette: palette)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(title)
        contentView.addSubview(textView)
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(palette: ColorSet, title: String, content: String) {
        
        setColors(palette: palette)
        self.title.text = title
        self.textView.text = content
    }
    
    func setColors(palette: ColorSet?) {
        guard let palette = palette else { return }

        self.title.textColor = palette.palette().text
        self.textView.textColor = palette.palette().text
        contentView.backgroundColor = palette.palette().noteBackground
    }
}
