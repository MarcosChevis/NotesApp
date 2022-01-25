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
    var viewModel: NoteCellViewModel?
    private var notificationService: NotificationService?
    
    var palette: ColorSet?
    
    override init(frame: CGRect) {
        noteContentView = NoteCellContentView(palette: .classic)
        noteContentView.translatesAutoresizingMaskIntoConstraints = false
        notificationService = nil

        super.init(frame: frame)
        contentView.addSubview(noteContentView)
        setupConstraints()
        setupStyle()
        noteContentView.textView.delegate = self
        noteContentView.title.delegate = self
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
    
    func setup(palette: ColorSet,
               viewModel: NoteCellViewModel,
               notificationService: NotificationService = NotificationCenter.default) {
        self.viewModel = viewModel
        self.palette = palette
        noteContentView.setup(palette: palette, viewModel: viewModel)
        self.notificationService = notificationService
        self.notificationService?.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    override func prepareForReuse() {
        viewModel = nil
        self.notificationService?.removeObserver(self)
        self.notificationService = nil
    }
}

extension NoteCollectionViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.note.content = textView.text
        notificationService?.post(name: .saveChanges, object: nil)
    }
}

extension NoteCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        noteContentView.textView.becomeFirstResponder()
    }
    
    @objc func textDidChange(_ notification: Notification) {
        updateViewModel(with: noteContentView.title.text ?? "Note")
        notificationService?.post(name: .saveChanges, object: nil)
    }
    
    private func updateViewModel(with title: String) {
        if title.isEmpty {
            viewModel?.note.title = String(title.prefix(10))
        } else {
            viewModel?.note.title = title
        }
    }
 }
