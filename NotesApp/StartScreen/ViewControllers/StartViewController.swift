//
//  ViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 13/07/21.
//

import UIKit

class StartViewController: UIViewController {
    
    private let coreData = CoreDataStack.shared
    var editingNote: Note?
    
    
    lazy var textView: UITextView = {
        textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemBackground
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Idea"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Notes", style: .plain, target: self, action: #selector(notesTapped))
        
        view.addSubview(textView)
        textView.becomeFirstResponder()
        
        setConstraints()
    }
    
    //MARK: CoreData
    func saveNote() {
        if let editingNote = self.editingNote {
            if textView.text != "" {
                editingNote.content = textView.text
                editingNote.modificationDate = Date()
            } else {
                coreData.delete(note: editingNote)
            }
        } else if textView.text != "" {
            _ = coreData.createNote(content: textView.text)
        }
        
        do {
            try coreData.save()
        } catch {
            coreData.mainContext.rollback()
        }
        
        textView.text = ""
        self.editingNote = nil
    }
    
    //MARK: Navigation
    @objc func notesTapped() {
        saveNote()
        let vc = NotesListTableViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Constraints
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
    func updateText(coreDataObject: Note) {
        editingNote = coreDataObject
        textView.text = coreDataObject.content
    }
    
}
