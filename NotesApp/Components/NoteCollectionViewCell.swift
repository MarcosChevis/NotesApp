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
    
    var palette: ColorSet? {
        didSet {
            setColors(palette: palette)
        }
    }
    
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
        let titleConstraints: [NSLayoutConstraint] = [
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let textViewConstraints: [NSLayoutConstraint] = [
            textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
    }
    
    private func setupStyle() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
    }
    
    func setup(palette: ColorSet, viewModel: NoteCellViewModel) {
        self.viewModel = viewModel
        
        self.palette = palette
        
        let provisoryTitle = viewModel.note.noteID.suffix(5)
        
        self.title.text = String(provisoryTitle)
        self.textView.text = viewModel.note.content
    }
    
    override func prepareForReuse() {
        viewModel = nil
    }
    
    func setColors(palette: ColorSet?) {
        guard let colorSet = palette?.palette() else { return }

        self.title.textColor = colorSet.text
        self.textView.textColor = colorSet.text
        contentView.backgroundColor = colorSet.noteBackground
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
