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
    var discardChange: Bool = false
    var initialText: String = ""
    
    lazy var textView: UITextView = {
        textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemBackground
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 18)
        
        return textView
    }()
    
    lazy var discardChangeButtom: UIBarButtonItem = {
        let but = UIBarButtonItem(title: "Discard", style: .plain, target: self, action: #selector(discardChanges))
        but.tintColor = .systemGray
        return but
    }()
    
    // MARK: UIKitLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Idea"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Notes", style: .plain, target: self, action: #selector(notesTapped))
        navigationItem.leftBarButtonItem = discardChangeButtom
        view.addSubview(textView)
        textView.becomeFirstResponder()
        
        setConstraints()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if !discardChange {
            saveNote()
        }
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
        initialText = ""
        self.editingNote = nil
        self.discardChange = false
    }
    
    //MARK: ButtonsFuncions
    @objc func notesTapped() {
        saveNote()
        let vc = NotesListTableViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func discardChanges() {
        textView.text = initialText
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
        initialText = textView.text
        self.discardChange = true
        discardChangeButtom.tintColor = .systemGray
    }
    
}

// MARK: UITextViewDelegate
extension StartViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == initialText {
            discardChangeButtom.tintColor = .systemGray
        } else {
            discardChangeButtom.tintColor = .systemRed
        }
    }
    
}
