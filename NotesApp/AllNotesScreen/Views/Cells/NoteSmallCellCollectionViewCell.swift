//
//  NoteSmallCellCollectionViewCell.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import UIKit
import SwiftUI

class NoteSmallCellCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "AllNotes.NoteSmallCellCollectionViewCell"
    var noteSmallContentView: NoteSmallCellContentView
    private var viewModel: NoteCellViewModel?
    private var palette: CustomColorSet? 
    

    var delegate: NoteSmallCellCollectionViewCellDelegate? {
        set {
            noteSmallContentView.delegate = newValue
        }
        get {
            noteSmallContentView.delegate
        }
    }
    
    private var shouldHidContent: Bool
    
    override init(frame: CGRect) {
        
        noteSmallContentView = NoteSmallCellContentView(palette: CustomColorSet.classic)
        noteSmallContentView.translatesAutoresizingMaskIntoConstraints = false
        self.shouldHidContent = true
        
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.addSubview(noteSmallContentView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let noteSmallContentViewConstraints: [NSLayoutConstraint] = [
            noteSmallContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            noteSmallContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            noteSmallContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            noteSmallContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(noteSmallContentViewConstraints)
    }
    
    func setup(palette: CustomColorSet, viewModel: NoteCellViewModel) {
        self.viewModel = viewModel
        self.palette = palette
        noteSmallContentView.setup(with: viewModel, palette: palette)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        delegate = nil
    }
}
