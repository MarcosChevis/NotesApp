//
//  ViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 13/07/21.
//

import UIKit

class StartViewController: UIViewController {
    
    lazy var textView: UITextView = {
        textView = UITextView(frame: .zero)
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
    
    
}

