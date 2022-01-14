//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    var palette: ColorSet
    var contentView: NoteView
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, NoteCellViewModel> = {
        let cellRegistration: UICollectionView.CellRegistration<NoteCollectionViewCell, NoteCellViewModel> = UICollectionView.CellRegistration<NoteCollectionViewCell, NoteCellViewModel> { cell, indexPath, note in
            cell.setup(colorPalette: ColorSet.classic.palette(), title: "Página \(indexPath.row)", content: note.note.content ?? "" )
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
        
        super.init(nibName: nil, bundle: nil)
        repository.delegate = self
        self.contentView.delegate = self
        contentView.collectionView.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
        } catch {
            
        }
    }
    
    func setupToolbar() {
        self.navigationController?.isToolbarHidden = false
        self.toolbarItems = contentView.toolbarItems
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    func setupNavigationBar() {
        title = "abrobinha"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = contentView.shareButton

    }
}

extension NoteViewController: NoteViewDelegate {
    func didDelete() {
        print("coisas de delete")
        
    }
    
    func didAllNotes() {
        print("coisas de all notes")
        
    }
    
    func didAdd() {
        do {
            try repository.createEmptyNote()
        } catch {
            
        }
    }
    
    func didShare() {
        print("coisas de share")
    }
}

extension NoteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
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
        snapshot.deleteItems([note])
        dataSource.apply(snapshot)
    }
    
    func updateNote(_ note: NoteCellViewModel, at indexPath: IndexPath) {
    }
}
