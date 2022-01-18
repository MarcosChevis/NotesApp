//
//  ThemesCollectionViewCell.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    var noteContentView: NoteCellContentView
    static var identifier: String = "Notes.NoteCollectionViewCell"
    
    
    

    private var viewModel: NoteCellViewModel?
    
    var palette: ColorSet?
    
    override init(frame: CGRect) {
        noteContentView = NoteCellContentView(palette: .classic)
        noteContentView.translatesAutoresizingMaskIntoConstraints = false

        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        setupStyle()
        noteContentView.textView.delegate = self
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        contentView.addSubview(noteContentView)
        
    }
    
    private func setupConstraints() {
        let noteContentViewConstraints: [NSLayoutConstraint] = [
            noteContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            noteContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            noteContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            noteContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(noteContentViewConstraints)
    }
    
    private func setupStyle() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
    }
    
    func setup(palette: ColorSet, viewModel: NoteCellViewModel) {
        self.viewModel = viewModel
        self.palette = palette
        noteContentView.setup(palette: palette, viewModel: viewModel)
    }
    
    override func prepareForReuse() {
        viewModel = nil
    }
    
    
    
}

extension NoteCollectionViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.note.content = textView.text
        NotificationCenter.default.post(name: .saveChanges, object: nil)
    }
    
    
}
