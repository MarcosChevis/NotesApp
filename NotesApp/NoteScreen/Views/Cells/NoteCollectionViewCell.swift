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
        contentView.addSubview(noteContentView)
        setupConstraints()
        setupStyle()
        noteContentView.textView.delegate = self
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 2, height: 2)
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
