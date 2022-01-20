//
//  NoteHeader.swift
//  NotesApp
//
//  Created by Rebecca Mello on 14/01/22.
//

import Foundation
import UIKit

class TagHeader: UICollectionReusableView {
    static var identifier: String = "tagHeaderID"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    func setup(with name: String, color: UIColor) {
        label.text = name
        label.textColor = color
    }
}
