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
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemBackground
        
        return textView
    }()
    
    init(initialText: String) {
        super.init(nibName: nil, bundle: nil)
        textView.text = initialText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Idea"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Notes", style: .plain, target: self, action: #selector(notesTapped))
        view.addSubview(textView)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        let textViewConstraints: [NSLayoutConstraint] = [
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(textViewConstraints)
        
    }
    
    @objc func notesTapped() {
        
        navigationController?.pushViewController(NotesListTableViewController(), animated: true)
    }
    
}

