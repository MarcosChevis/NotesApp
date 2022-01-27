//
//  CustomThemeBuilderCollectionViewCellContentView.swift
//  NotesApp
//
//  Created by Marcos Chevis on 26/01/22.
//

import UIKit

class CustomThemeBuilderCollectionViewCellContentView: ThemableView {

    lazy var colorView: UIView = {
        var view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        
        view.layer.shadowPath = UIBezierPath(roundedRect: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)), cornerRadius: 8).cgPath
        
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.masksToBounds = false
        
        
        return view
    }()
    
    lazy var colorNameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
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
    
    func setupHierarchy() {
        addSubview(colorView)
        addSubview(colorNameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 100),
            colorView.widthAnchor.constraint(equalTo: colorView.heightAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            colorNameLabel.centerYAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 30),
            colorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func setColors(palette: ColorSet) {
        colorNameLabel.textColor = palette.palette().text
        colorView.layer.shadowColor = palette.palette().actionColor.cgColor
    }
    
    
    
}
