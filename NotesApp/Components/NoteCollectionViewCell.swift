//
//  ThemesCollectionViewCell.swift
//  NotesApp
//
//  Created by Rebecca Mello on 12/01/22.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "Notes.NoteCollectionViewCell"
    
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
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.delegate = self
        return textView
    }()
    
    private var viewModel: NoteCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        
        contentView.addSubview(title)
        contentView.addSubview(textView)
    }
    
    private func setupConstraints() {
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    private func setupStyle() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
    }
    
    func setup(colorPalette: CustomColorSet, viewModel: NoteCellViewModel) {
        self.viewModel = viewModel
        
        self.title.textColor = .black
        self.textView.textColor = .black
        contentView.backgroundColor = .white
        
        let provisoryTitle = viewModel.note.noteID.suffix(5)
        
        self.title.text = String(provisoryTitle)
        self.textView.text = viewModel.note.content
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
