//
//  ThemableView.swift
//  NotesApp
//
//  Created by Caroline Taus on 18/01/22.
//

import Foundation
import UIKit

class ThemableView: UIView {
    var palette: ColorSet{
        didSet {
            setColors(palette: palette)
        }
    }
    
    let notificationService: NotificationService
    let settings: Settings
    
    init(palette: ColorSet, notificationService: NotificationService,
         settings: Settings) {
        self.settings = settings
        self.notificationService = notificationService
        self.palette = palette
        super.init(frame: .zero)
        
        setColors(palette: palette)
        setupBindings()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        notificationService.removeObserver(self)
    }
    
    func setupBindings() {
        notificationService.addObserver(self, selector: #selector(didChangeTheme), name: .didChangeTheme, object: nil)
    }
    
    @objc func didChangeTheme(_ notification: Notification) {
        guard let palette = notification.object as? ColorSet else { return }
        self.palette = palette
        
    }
    
    func setColors(palette: ColorSet) {
        // Deve ficar vazia, pois essa função será implementada em outras classes que têm herdam dessa
    }
}
