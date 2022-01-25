//
//  ExampleView.swift
//  NotesApp
//
//  Created by Marcos Chevis on 25/01/22.
//

import UIKit

class ThemeExampleView: ThemableView {
    
    lazy var shareButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        
        return but
    }()
    
    lazy var bigTitle: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Page 1"
        label.font = UIFont.boldSystemFont(ofSize: 20)
       
        return label
    }()

    lazy var middleView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 16
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        return view
    }()
    
    lazy var trashButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "trash"), for: .normal)
        
        return but
    }()
    
    lazy var noteButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "note.text"), for: .normal)
        
        return but
    }()
    
    lazy var plusButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "plus"), for: .normal)
        
        return but
    }()
    
    lazy var smallTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 12)
        
        textView.text = """
                        You can change the theme of your Swift Notes app.

                        Try them all and find your favorites!
                        """
        
        return textView
    }()
    
    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = Settings()) {
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        
        isUserInteractionEnabled = false
        
        layer.cornerRadius = 8
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 2, height: 2)
        
        layer.shadowOpacity = 0.5
        
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(shareButton)
        addSubview(bigTitle)
        addSubview(middleView)
        addSubview(trashButton)
        addSubview(noteButton)
        addSubview(plusButton)
        middleView.addSubview(smallTitle)
        middleView.addSubview(textView)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            shareButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            bigTitle.topAnchor.constraint(equalTo: shareButton.bottomAnchor),
            bigTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            middleView.topAnchor.constraint(equalTo: bigTitle.bottomAnchor, constant: 4),
            middleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            middleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            middleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            trashButton.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: 4),
            trashButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            trashButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            noteButton.topAnchor.constraint(equalTo: trashButton.topAnchor),
            noteButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: trashButton.topAnchor),
            plusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            smallTitle.topAnchor.constraint(equalTo: middleView.topAnchor, constant: 8),
            smallTitle.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: smallTitle.bottomAnchor, constant: 4),
            textView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -8),
            textView.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -8)
        ])

        
    }

    override func setColors(palette: ColorSet) {
        super.setColors(palette: palette)
        let colorSet = palette.palette()
        backgroundColor = colorSet.background
        shareButton.tintColor = colorSet.actionColor
        bigTitle.textColor = colorSet.largeTitle
        middleView.backgroundColor = colorSet.noteBackground
        trashButton.tintColor = colorSet.actionColor
        noteButton.tintColor = colorSet.actionColor
        plusButton.tintColor = colorSet.actionColor
        smallTitle.textColor = colorSet.text
        textView.textColor = colorSet.text

        
        layer.shadowColor = colorSet.actionColor.cgColor
        
        smallTitle.text = palette.rawValue.capitalized + " Theme"
    }
    
}
