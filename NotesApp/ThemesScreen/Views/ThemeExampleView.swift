//
//  ExampleView.swift
//  NotesApp
//
//  Created by Marcos Chevis on 25/01/22.
//

import UIKit

class ThemeExampleView: ThemableView {
    
    lazy var shareButton: UIButton = {
        let but = UIButton(systemImage: "square.and.arrow.up") { return }
        but.layer.cornerRadius = 5.45
        but.translatesAutoresizingMaskIntoConstraints = false
        
        return but
    }()
    
    lazy var bigTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(format: NSLocalizedString(.noteTitle), 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
       
        return label
    }()

    lazy var middleView: UIView = {
        let view = UIView()
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
        let but = UIButton(systemImage: "trash") { return }
        but.translatesAutoresizingMaskIntoConstraints = false
        but.layer.cornerRadius = 5.45
        
        return but
    }()
    
    
    
    lazy var noteButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "menucard"), for: .normal)
        
        return but
    }()
    
    lazy var plusButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "plus"), for: .normal)
        
        return but
    }()
    
    lazy var smallTitle: UILabel = {
        let label = UILabel()
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
                        \(NSLocalizedString(.examplePhrase1))

                        \(NSLocalizedString(.examplePhrase2))
                        """
        
        return textView
    }()
    
    override init(palette: ColorSet, notificationService: NotificationService = NotificationCenter.default,
                  settings: Settings = .shared) {
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
        addSubview(bigTitle)
        addSubview(middleView)
        addSubview(noteButton)
        addSubview(plusButton)
        middleView.addSubview(shareButton)
        middleView.addSubview(trashButton)
        middleView.addSubview(smallTitle)
        middleView.addSubview(textView)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            noteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            noteButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            bigTitle.topAnchor.constraint(equalTo: plusButton.bottomAnchor),
            bigTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bigTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            middleView.topAnchor.constraint(equalTo: bigTitle.bottomAnchor, constant: 8),
            middleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            middleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            middleView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            smallTitle.topAnchor.constraint(equalTo: middleView.topAnchor, constant: 8),
            smallTitle.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: smallTitle.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -8),
            textView.bottomAnchor.constraint(equalTo: trashButton.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            shareButton.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -8),
            shareButton.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -8),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            trashButton.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 8),
            trashButton.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -8),
            trashButton.widthAnchor.constraint(equalToConstant: 30),
            trashButton.heightAnchor.constraint(equalToConstant: 30)
        ])

    }

    override func setColors(palette: ColorSet) {
        super.setColors(palette: palette)
        backgroundColor = palette.background
        shareButton.tintColor = palette.actionColor
        bigTitle.textColor = palette.largeTitle
        middleView.backgroundColor = palette.noteBackground
        trashButton.tintColor = palette.actionColor
        noteButton.tintColor = palette.actionColor
        plusButton.tintColor = palette.actionColor
        smallTitle.textColor = palette.text
        textView.textColor = palette.text
        
        trashButton.backgroundColor = palette.buttonBackground
        shareButton.backgroundColor = palette.buttonBackground

        layer.shadowColor = palette.actionColor?.cgColor
        
        smallTitle.text = String(format: NSLocalizedString(.themeExample), palette.name)
    }
    
    func setColorsForCustomTheme(colorSet: ThemeProtocol) {
        
        backgroundColor = colorSet.background
        shareButton.tintColor = colorSet.actionColor
        bigTitle.textColor = colorSet.largeTitle
        middleView.backgroundColor = colorSet.noteBackground
        trashButton.tintColor = colorSet.actionColor
        noteButton.tintColor = colorSet.actionColor
        plusButton.tintColor = colorSet.actionColor
        smallTitle.textColor = colorSet.text
        textView.textColor = colorSet.text
        
        trashButton.backgroundColor = colorSet.buttonBackground
        shareButton.backgroundColor = colorSet.buttonBackground

        layer.shadowColor = colorSet.actionColor?.cgColor
        
        smallTitle.text = colorSet.name?.capitalized ?? "" + " Theme"
    }
    
}
