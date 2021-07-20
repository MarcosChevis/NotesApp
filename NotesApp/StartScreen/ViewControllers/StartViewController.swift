//
//  ViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 13/07/21.
//

import UIKit

class StartViewController: UIViewController {
    
    var singleton: Singleton = Singleton.shared
    
    lazy var textView: UITextView = {
        textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemBackground
        
        return textView
    }()
    
    init(initialText: String) {  //id, if nil: is new note
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
        textView.becomeFirstResponder()
        
        setConstraints()
    }
    
    func saveNote() {
        if textView.text != "" {
            singleton.data.append(NoteData(content: textView.text, tags: [], creationDate: Date(), modificationDate: Date()))
        }
        textView.text = ""
    }

    @objc func notesTapped() {
        saveNote()
        let vc = NotesListTableViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
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

}

// MARK: NoteListViewControllerDelegate
extension StartViewController: NoteListViewControllerDelegate {
    func updateText(text: String) {
        textView.text = text
    }
    
    
}
