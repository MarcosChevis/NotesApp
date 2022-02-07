//
//  NoteCellContentView.swift
//  NotesApp
//
//  Created by Caroline Taus on 18/01/22.
//

import Foundation
import UIKit

class NoteCellContentView: ThemableView {
    private var viewModel: NoteCellViewModel?
    
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
    
    private var placeholder: NSMutableAttributedString
    private var placeholderContent: String = NSLocalizedString(.noteTitlePlaceholder)
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(systemImage: "trash") { [weak self] in
            guard let action = self?.deleteAction else { return }
            action()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(systemImage: "square.and.arrow.up") { [weak self] in
            guard let action = self?.shareAction else { return }
            action()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shareButton)
        view.addSubview(deleteButton)
        
        let buttonConstraints: [NSLayoutConstraint] = [
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 44),
            deleteButton.heightAnchor.constraint(equalTo: deleteButton.widthAnchor),
            
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 44),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
        
        return view
    }()
    
    var shareAction: (() -> Void)?
    var deleteAction: (() -> Void)?
    
    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
                  settings: Settings = .shared) {
        
        placeholder = .init(string: placeholderContent)
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(title)
        addSubview(textView)
        addSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        let titleConstraints: [NSLayoutConstraint] = [
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        let textViewConstraints: [NSLayoutConstraint] = [
            textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        let buttonStackView: [NSLayoutConstraint] = [
            buttonsStackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 44),
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
        NSLayoutConstraint.activate(buttonStackView)
    }
    
    func setup(palette: ColorSet, viewModel: NoteCellViewModel) {
        self.palette = palette
        self.title.text = viewModel.note.title
        self.textView.text = viewModel.note.content
        
        title.attributedPlaceholder = placeholder
        setupStyle()
    }
    
    func setupStyle() {
        layer.masksToBounds = false
        layer.cornerRadius = 16
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    override func setColors(palette: ColorSet?) {
        guard let palette = palette else { return }
        
        self.title.textColor = palette.text
        self.textView.textColor = palette.text
        backgroundColor = palette.noteBackground
        self.deleteButton.tintColor = palette.actionColor
        self.deleteButton.backgroundColor = palette.buttonBackground
        self.shareButton.tintColor = palette.actionColor
        self.shareButton.backgroundColor = palette.buttonBackground
        
        guard let textColor = palette.text?.withAlphaComponent(0.4) else { return }
        
        let attributeRange = NSRange(location: 0, length: placeholderContent.count)
        placeholder.removeAttribute(NSAttributedString.Key.foregroundColor, range: attributeRange)
        placeholder.addAttributes([NSAttributedString.Key.foregroundColor: textColor], range: attributeRange)
        layer.shadowColor = UIColor.black.cgColor
        
    }
}
