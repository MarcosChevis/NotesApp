//
//  NoteSmallCellContentView.swift
//  NotesApp
//
//  Created by Caroline Taus on 20/01/22.
//

import Foundation
import UIKit

class NoteSmallCellContentView: ThemableView {
    private var viewModel: NoteCellViewModel?
    weak var delegate: NoteSmallCellCollectionViewCellDelegate?
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        
        if let descriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .title2)
            .withSymbolicTraits(.traitBold) {
            label.font = UIFont(descriptor: descriptor, size: 0)
        } else {
            label.font = .preferredFont(forTextStyle: .title2)
        }
        
        label.textAlignment = .left
        label.numberOfLines = 1
        
        return label
    }()
    
    
    private lazy var contentTextView: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 2
            
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.addArrangedSubview(deleteButton)
        stack.addArrangedSubview(shareButton)
        stack.addArrangedSubview(editButton)
          
        return stack
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.layer.cornerRadius = 8
        button.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self, let viewModel = self.viewModel else { return }
            self.delegate?.didTapDelete(for: viewModel)
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.layer.cornerRadius = 8
        button.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self, let viewModel = self.viewModel else { return }
            self.delegate?.didTapShare(for: viewModel)
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.layer.cornerRadius = 8
        button.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self, let viewModel = self.viewModel else { return }
            self.delegate?.didTapEdit(for: viewModel)
        }), for: .touchUpInside)
        
        return button
    }()
    
    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
                  settings: Settings = .shared) {
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(titleView)
        addSubview(contentTextView)
        addSubview(buttonsStackView)
    }
    
    func setupConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        let titleViewConstraints: [NSLayoutConstraint] = [
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        let contentTextViewConstraints: [NSLayoutConstraint] = [
            contentTextView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 4),
            contentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        let buttonsStackViewConstraints: [NSLayoutConstraint] = [
            buttonsStackView.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 16),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        let deleteButtonConstraints: [NSLayoutConstraint] = [
            deleteButton.widthAnchor.constraint(equalToConstant: 36),
            deleteButton.heightAnchor.constraint(equalTo: deleteButton.widthAnchor)
        ]
        
        let shareButtonConstraints: [NSLayoutConstraint] = [
            shareButton.widthAnchor.constraint(equalToConstant: 36),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
        ]
        
        let editButtonConstraints: [NSLayoutConstraint] = [
            editButton.widthAnchor.constraint(equalToConstant: 36),
            editButton.heightAnchor.constraint(equalTo: editButton.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(titleViewConstraints)
        NSLayoutConstraint.activate(contentTextViewConstraints)
        NSLayoutConstraint.activate(buttonsStackViewConstraints)
        NSLayoutConstraint.activate(deleteButtonConstraints)
        NSLayoutConstraint.activate(shareButtonConstraints)
        NSLayoutConstraint.activate(editButtonConstraints)
    }
    
    func setup(with viewModel: NoteCellViewModel, palette: ColorSet) {
        self.palette = palette
        self.viewModel = viewModel
        titleView.text = viewModel.note.title
        contentTextView.text = viewModel.note.content
        buttonsStackView.axis = .horizontal
    }
    
    override func setColors(palette: ColorSet?) {
        guard let palette = palette else { return }
        
        titleView.textColor = palette.text
        contentTextView.textColor = palette.text
        editButton.tintColor = palette.actionColor
        editButton.backgroundColor = palette.buttonBackground
        deleteButton.tintColor = palette.actionColor
        deleteButton.backgroundColor = palette.buttonBackground
        shareButton.tintColor = palette.actionColor
        shareButton.backgroundColor = palette.buttonBackground
        backgroundColor = palette.noteBackground
    }
}
