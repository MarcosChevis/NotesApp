//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import Foundation
import UIKit

class NoteViewController: ThemableViewController {
    private var contentView: NoteView
    private var currentHighlightedNote: NoteProtocol?
    
    private lazy var dataSource: NoteDataSource = {
        let cellRegistration: NoteCellRegistration = makeNoteCellRegistration()
        let dataSource: NoteDataSource = makeDatasource(with: cellRegistration)
        return dataSource
    }()
    
    private let repository: NotesRepositoryProtocol
    
    
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
    
    private func setupKeyboardDismissGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func setupInitialData() {
        do {
            let data = try repository.getInitialData()
            var snapshot = dataSource.snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(data, toSection: .main)
            dataSource.apply(snapshot, animatingDifferences: false)
        } catch {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollToEmptyNote(animated)
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
        do {
            _ = try repository.createEmptyNote()
            let count = dataSource.snapshot().numberOfItems
            contentView.collectionView.scrollToItem(at: IndexPath(row: count-1, section: 0), at: .centeredHorizontally, animated: animated)
        } catch {
            
        }
    }
    
    private func presentAlert(for alertCase: UIAlertController.CommonAlert, _ action: @escaping() -> Void) {
        let alert = UIAlertController.singleActionAlert(for: alertCase) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            action()
        }
        self.present(alert, animated: true)
    }
    
    private func presentErrorAlert(with errorMessage: String) {
        let alert = UIAlertController.errorAlert(for: .unexpectedError(error: errorMessage))
        self.present(alert, animated: true)
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

extension NoteViewController: NoteViewDelegate {
    
    func collectionViewDidMove(to indexPath: IndexPath) {
        guard let note = dataSource.itemIdentifier(for: indexPath)?.note,
              currentHighlightedNote?.noteID != note.noteID || currentHighlightedNote == nil else {
                  return
              }
        
        currentHighlightedNote = note
        print(note.noteID)
        
        title = "Page \(indexPath.row)"
    }
    
    func didDelete() {
        presentAlert(for: .onDeletingItem) { [weak self] in
            guard let self = self else { return }
            self.deleteNote()
        }
    }
    
    func didAllNotes() {
        print("coisas de all notes")
        
    }
    
    func didAdd() {
        do {
            _ = try repository.createEmptyNote()
        } catch {
            
        }
    }
    
    func didShare() {
        guard let currentHighlightedNote = self.currentHighlightedNote else {
            presentErrorAlert(with: "You do not have notes to share")
            return
        }
        
        do {
            let shareScreen = try UIActivityViewController.shareNote(currentHighlightedNote)
            present(shareScreen, animated: true, completion: nil)
        } catch {
            presentErrorAlert(with: "Your note is empty")
        }
        
    }
}

private extension NoteViewController {
    private enum Section {
        case main
    }
    
    private typealias NoteDataSource = UICollectionViewDiffableDataSource<Section, NoteCellViewModel>
    private typealias NoteCellRegistration = UICollectionView.CellRegistration<NoteCollectionViewCell, NoteCellViewModel>
    
    private func makeNoteCellRegistration() -> NoteCellRegistration {
        NoteCellRegistration { [weak self] cell, indexPath, note in
            guard let self = self else { return }
            cell.setup(palette: self.palette, viewModel: note)
        }
    }
    
    private func makeDatasource(with noteCellRegistration: NoteCellRegistration) -> NoteDataSource {
        NoteDataSource(collectionView: contentView.collectionView) { collectionView, indexPath, viewModel in
            collectionView.dequeueConfiguredReusableCell(using: noteCellRegistration, for: indexPath, item: viewModel)
        }
    }
}

extension NoteViewController: NoteRepositoryProtocolDelegate {
    func insertNote(_ note: NoteCellViewModel, at indexPath: IndexPath) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([note], toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
        contentView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func deleteNote(_ note: NoteCellViewModel) {
        var snapshot = dataSource.snapshot()
        
        guard let viewModel = snapshot.itemIdentifiers.filter({ note.note.noteID == $0.note.noteID }).first
        else {
            return
        }
        
        snapshot.deleteItems([viewModel])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
