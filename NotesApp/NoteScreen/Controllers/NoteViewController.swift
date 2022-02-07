//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit

class NoteViewController: ThemableViewController {
    private var contentView: NoteView
    private var currentHighlightedNote: NoteProtocol?
    weak var coordinator: MainCoordinatorProtocol?
    
    private lazy var dataSource: NoteDataSource = {
        let cellRegistration: NoteCellRegistration = makeNoteCellRegistration()
        let dataSource: NoteDataSource = makeDatasource(with: cellRegistration, for: contentView.collectionView)
        return dataSource
    }()
    
    private let repository: NotesRepositoryProtocol
    
    
    init(contentView: NoteView,
         palette: ColorSet,
         repository: NotesRepositoryProtocol,
         notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = .shared) {
        self.contentView = contentView
        
        self.repository = repository
        self.currentHighlightedNote = nil
        
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupBindings() {
        super.setupBindings()
        self.repository.delegate = self
        self.contentView.delegate = self
        contentView.collectionView.dataSource = dataSource
    }
    
    //MARK: Life Cycle
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupKeyboardDismissGesture()
        setupInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            let data = try repository.getInitialData()
            var snapshot = dataSource.snapshot()
            
            
            if snapshot.numberOfItems > 0 {
                snapshot.deleteAllItems()
                snapshot.appendSections([.main])
            }
            
            snapshot.appendItems(data, toSection: .main)
            dataSource.apply(snapshot, animatingDifferences: false)
        } catch  {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToEmptyNote()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        repository.saveChangesWithoutEmptyNotes()
    }
    
    private func setupKeyboardDismissGesture() {
        contentView.addEndEditingTapGesture()
    }
    
    private func setupInitialData() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [contentView.addButton, contentView.allNotesButton, ]
    }
    
    //MARK: Collection View Operations
    
    func scrollToEmptyNote(_ animated: Bool = false) {
        repository.saveChangesWithoutEmptyNotes()
        createNote()
        let count = dataSource.snapshot().numberOfItems
        scrollToNote(at: count-1)
    }
    
    func insertNoteIntoDatasource(_ note: NoteCellViewModel) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([note], toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
        guard let indexPath = dataSource.indexPath(for: note) else { return }
        contentView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func deleteNoteIntoDatasource(_ note: NoteCellViewModel) {
        var snapshot = dataSource.snapshot()
        
        guard let viewModel = snapshot.itemIdentifiers.filter({ note.note.noteID == $0.note.noteID }).first
        else {
            return
        }
        
        snapshot.deleteItems([viewModel])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func highlightNote(with id: String) {
        let snapshot = dataSource.snapshot()
        
        guard
            let item = snapshot.itemIdentifiers.first(where: { $0.note.noteID == id }),
            let index = snapshot.indexOfItem(item)
        else {
            return
        }
        scrollToNote(at: index, animated: true)
    }
    
    private func scrollToNote(at index: Int, animated: Bool = true) {
        contentView.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: animated)
    }
    
    //MARK: CRUD Operations
    
    func createNote() {
        do {
            _ = try repository.createEmptyNote()
        } catch {
            coordinator?.presentErrorAlert(with: NSLocalizedString(.alertErrorAddingNote))
        }
    }
    
    func deleteNote(_ note: NoteProtocol) {
        coordinator?.presentSingleActionAlert(for: .onDeletingItem) { [weak self] in
            guard let self = self else { return }
            do {
                try self.repository.deleteNote(note)
            } catch {
                self.coordinator?.presentErrorAlert(with: NSLocalizedString(.alertErrorDeletingNote))
            }
        }
    }
    
    //MARK: Navigation
    
    func navigateToAllNotes() {
        repository.saveChangesWithoutEmptyNotes()
        coordinator?.navigateToAllNotes()
    }
    
    func shareNote(_ note: NoteProtocol) {
        guard let content = note.content, !content.isEmpty else {
            coordinator?.presentErrorAlert(with: NSLocalizedString(.alertEmptyNote))
            return
        }
        
        coordinator?.shareContent(content)
    }
}
