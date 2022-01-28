//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import UIKit

class NoteViewController: ThemableViewController {
    var contentView: NoteView
    var currentHighlightedNote: NoteProtocol?
    weak var coordinator: MainCoordinatorProtocol?
    
    lazy var dataSource: NoteDataSource = {
        let cellRegistration: NoteCellRegistration = makeNoteCellRegistration()
        let dataSource: NoteDataSource = makeDatasource(with: cellRegistration)
        return dataSource
    }()
    
    let repository: NotesRepositoryProtocol
    
    
    init(palette: ColorSet,
         repository: NotesRepositoryProtocol,
         notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = Settings()) {
        self.contentView = NoteView(palette: palette)

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
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupKeyboardDismissGesture()
        setupToolbar()
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
        scrollToEmptyNote(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        repository.saveChangesWithoutEmptyNotes()
    }
    
    private func setupKeyboardDismissGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func setupInitialData() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func setupToolbar() {
        self.navigationController?.isToolbarHidden = false
        self.toolbarItems = contentView.toolbarItems
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = contentView.shareButton   
    }
    
    
    private func scrollToEmptyNote(_ animated: Bool = false) {
        repository.saveChangesWithoutEmptyNotes()
        do {
            _ = try repository.createEmptyNote()
            let count = dataSource.snapshot().numberOfItems
            contentView.collectionView.scrollToItem(at: IndexPath(row: count-1, section: 0), at: .centeredHorizontally, animated: animated)
        } catch {
            
        }
    }
    
    func deleteNote() {
        guard let currentHighlightedNote = self.currentHighlightedNote else {
            return
        }
        do {
            self.currentHighlightedNote = nil
            try self.repository.deleteNote(currentHighlightedNote)
        } catch {
            self.presentErrorAlert(with: "It was not possible to delete this note!")
        }
    }
}
