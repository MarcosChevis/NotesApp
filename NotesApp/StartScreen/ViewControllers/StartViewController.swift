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
    var initialText: String = ""
    
    var defaults = UserDefaults.standard
    
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
    
    lazy var allButtom: UIBarButtonItem = {
        let but = UIBarButtonItem(title: "Todas", style: .plain, target: self, action: #selector(notesTapped))
        
        return but
    }()
    
    lazy var newNote: UIBarButtonItem = {
        let but = UIBarButtonItem(image: UIImage(systemName: "note.text.badge.plus"), style: .plain, target: self, action: #selector(saveAndNewNote))
        
        return but
    }()
        
    // MARK: UIKitLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.bool(forKey: "First Launch") != true {
            initialText = """
                            Escreva o que está pensando,
                            E salve sua nota apenas fechando o app!
                            
                            É possível salvar e abrir uma nova nota no ícone à direita.
                            Para vizualizar todas suas notas vá em "Todas".
                            
                            Para deletar é só deixar a Nota vazia,
                            Ou pode deletar uma arrastando para a esquerda em "Todas".
                            
                            Nunca mais se esqueça de algo antes de anotar!
                            """
            textView.text = initialText
            
            defaults.setValue(true, forKey: "First Launch")
        } else {
            defaults.setValue(true, forKey: "First Launch")
        }
        
        title = "Nota"
        navigationItem.setRightBarButtonItems([allButtom, newNote], animated: true)
        navigationItem.leftBarButtonItem = discardChangeButtom
        view.addSubview(textView)
        textView.becomeFirstResponder()
        
        setConstraints()
    }
    override func viewWillDisappear(_ animated: Bool) {
            saveNote()
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
        checkTextView()
    }
    
    @objc func saveAndNewNote() {
        saveNote()
        editingNote = nil
        textView.text = ""
        initialText = textView.text
        checkTextView()
    }
    
    //MARK: Logic
    func checkTextView() {
        if textView.text == initialText {
            discardChangeButtom.tintColor = .systemGray
        } else {
            discardChangeButtom.tintColor = .systemRed
        }

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
        discardChangeButtom.tintColor = .systemGray
    }
    
}

// MARK: UITextViewDelegate
extension StartViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        checkTextView()
        
    }
    
}
