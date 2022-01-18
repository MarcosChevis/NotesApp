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
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.backgroundColor = .clear
        return textView
    }()
    
    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
                  settings: Settings = Settings()) {
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
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
    }
    
    func setup(palette: ColorSet, viewModel: NoteCellViewModel) {
        
        
        self.palette = palette
        
        let provisoryTitle = viewModel.note.noteID.suffix(5)
        
        self.title.text = String(provisoryTitle)
        self.textView.text = viewModel.note.content
    }
    
    override func setColors(palette: ColorSet?) {
        guard let colorSet = palette?.palette() else { return }
        
        self.title.textColor = colorSet.text
        self.textView.textColor = colorSet.text
        backgroundColor = colorSet.noteBackground
    }
}
