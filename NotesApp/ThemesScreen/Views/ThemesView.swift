//
//  ThemesView.swift
//  NotesApp
//
//  Created by Caroline Taus on 14/01/22.
//

import UIKit

class ThemesView: UIView {
    var palette: ColorSet
    
    lazy var exampleImage: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        addSubview(img)
        
        return img
    }()

    init(palette: ColorSet) {
        self.palette = palette
        
        super.init(frame: .zero)
        
        backgroundColor = palette.palette().background
        setupConstraints()
        setExampleImage(color: .neon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            exampleImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            exampleImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -200),
            exampleImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            exampleImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)])
    }
    
    func setExampleImage(color: ColorSet) {
        switch color {
        case .neon:
            exampleImage.image = UIImage(named: "totiNeon")
        case .classic:
            exampleImage.image = UIImage(named: "toti")
        }
    }
}
