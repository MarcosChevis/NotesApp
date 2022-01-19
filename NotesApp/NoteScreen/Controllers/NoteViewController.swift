//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    private var palette: ColorSet
    private var contentView: NoteView
    private var currentHighlightedNote: NoteProtocol?
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, NoteCellViewModel> = {
        let cellRegistration: UICollectionView.CellRegistration<NoteCollectionViewCell, NoteCellViewModel> = UICollectionView.CellRegistration<NoteCollectionViewCell, NoteCellViewModel> { cell, indexPath, note in
            cell.setup(colorPalette: ColorSet.classic, viewModel: note)
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Section, NoteCellViewModel>(collectionView: contentView.collectionView)
        { collectionView, indexPath, viewModel in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: viewModel)
        }
        
        return dataSource
    }()
    
    private let repository: NotesRepositoryProtocol
    
    
    init(palette: ColorSet, repository: NotesRepositoryProtocol) {
        self.contentView = NoteView(palette: palette)
        self.palette = palette
        self.repository = repository
        self.currentHighlightedNote = nil
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        self.repository.delegate = self
        self.contentView.delegate = self
        contentView.collectionView.dataSource = dataSource
        contentView.collectionView.delegate = self
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        setupNavigationBar()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setupToolbar()
        
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
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
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
    
    private func presentAlert(with content: UIAlertController.AlertContent, _ action: @escaping() -> Void) {
        let alert = UIAlertController.singleActionAlert(with: content) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            action()
        }
        self.present(alert, animated: true)
    }
    
    private func presentErrorAlert(with errorMessage: String) {
        let content = UIAlertController.AlertContent(title: "Um erro aconteceu!", message: errorMessage, actionTitle: "", actionStyle: .default)
        
        let alert = UIAlertController.errorAlert(with: content)
        self.present(alert, animated: true)
    }
    
    func deleteNote() {
        guard let currentHighlightedNote = self.currentHighlightedNote else {
            return
        }
    
        do {
            try self.repository.deleteNote(currentHighlightedNote)
        } catch {
            self.presentErrorAlert(with: "Não foi possivel deletar esse item")
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
        let content: UIAlertController.AlertContent = .init(title: "Tem certeza que deseja deletar?",
                                                            message: "Essa ação não é reversível",
                                                            actionTitle: "Deletar",
                                                            actionStyle: .destructive)
        presentAlert(with: content) { [weak self] in
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
        let note = "ooooi"
        
        // set up activity view controller
        let noteToShare = note
        let activityViewController = UIActivityViewController(activityItems: [noteToShare], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}

extension NoteViewController: UICollectionViewDelegate {
    
}

extension NoteViewController {
    private enum Section {
        case main
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
        
        guard let viewModel = snapshot.itemIdentifiers.filter({ note.note.noteID == $0.note.noteID }).first else {
            return
            }
        
        snapshot.deleteItems([viewModel])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func updateNote(_ note: NoteCellViewModel, at indexPath: IndexPath) {
        
    }
}
