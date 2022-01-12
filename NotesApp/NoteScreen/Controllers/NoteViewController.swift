//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    
    var contentView: NoteView
    
    init() {
        self.contentView = NoteView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
}
