//
//  ThemesCollectionViewCell.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import Foundation
import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    var title: UILabel = {
        var title = UILabel()
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .preferredFont(forTextStyle: .title2)
        return title
    }()
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        self.addSubview(textView)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        title.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        title.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
