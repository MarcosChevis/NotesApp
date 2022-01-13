//
//  NoteSmallCellCollectionViewCell.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import UIKit

class NoteSmallCellCollectionViewCell: UICollectionViewCell {
    
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
        
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        let constraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
        return label
    }()
    
    private lazy var contentTextView: UILabel = {
        let label = UILabel()

        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 2

        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        let constraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
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
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        let constraints: [NSLayoutConstraint] = [
            stack.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return stack
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.layer.cornerRadius = 8
        
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            button.widthAnchor.constraint(equalToConstant: 36),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
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
        
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            button.widthAnchor.constraint(equalToConstant: 36),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
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
        
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            button.widthAnchor.constraint(equalToConstant: 36),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        button.addAction(UIAction(handler: {[weak self] _ in
            guard let self = self, let viewModel = self.viewModel else { return }
            self.delegate?.didTapEdit(for: viewModel)
        }), for: .touchUpInside)
        
        return button
    }()
    
    weak var delegate: NoteSmallCellCollectionViewCellDelegate?
    
    private var shouldHidContent: Bool
    private var palette: CustomColorSet?
    private var viewModel: SmallNoteCellViewModel?
    
    override init(frame: CGRect) {
        self.shouldHidContent = true
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(with viewModel: SmallNoteCellViewModel) {
        setupColorSet(viewModel.colorSet.palette())
        titleView.text = viewModel.title
        contentTextView.text = viewModel.content
        buttonsStackView.axis = .horizontal
    }
    
    private func setupColorSet(_ palette: CustomColorSet) {
        if self.palette == nil {
            self.palette = palette
            setupColors(palette)
            return
        }
        
        guard let actualPalette = self.palette, actualPalette != palette else {
            return
        }
        
        self.palette = palette
        setupColors(palette)
    }
    
    private func setupColors(_ palette: CustomColorSet) {
        titleView.textColor = palette.text
        
        editButton.tintColor = palette.actionColor
        editButton.backgroundColor = palette.buttonBackground
        
        deleteButton.tintColor = palette.actionColor
        deleteButton.backgroundColor = palette.buttonBackground
        
        shareButton.tintColor = palette.actionColor
        shareButton.backgroundColor = palette.buttonBackground
        
        contentView.backgroundColor = .white
    }
    
}
