//
//  AllNotesViewController.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import UIKit

class AllNotesViewController: UIViewController {
    
    var palette: ColorSet
    var contentView: AllNotesView
    private let tagsRepository: TagRepositoryProtocol
    private let noteRepository: NotesRepositoryProtocol
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        let noteCellRegistration:
        UICollectionView.CellRegistration<NoteSmallCellCollectionViewCell, NoteCellViewModel> =
        UICollectionView.CellRegistration<NoteSmallCellCollectionViewCell, NoteCellViewModel> { cell, indexPath, note in
            cell.setup(with: note, colorSet: .classic)
        }
        
        let tagCellRegistration:
        UICollectionView.CellRegistration<TagCollectionViewCell, TagCellViewModel> =
        UICollectionView.CellRegistration<TagCollectionViewCell, TagCellViewModel> { cell, indexPath, tag in
            cell.setup(with: tag, colorSet: .classic)
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: contentView.collectionView)
        { collectionView, indexPath, item in
            switch item {
            case .tag(let tagViewModel):
                return collectionView.dequeueConfiguredReusableCell(using: tagCellRegistration, for: indexPath, item: tagViewModel)
            
            case .note(let noteViewModel):
                return collectionView.dequeueConfiguredReusableCell(using: noteCellRegistration, for: indexPath, item: noteViewModel)
            }
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView,
                                                  kind: String,
                                                  indexPath: IndexPath) -> UICollectionReusableView? in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                if indexPath.section == 0 {
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TagHeader.identifier, for: indexPath) as? TagHeader else {
                        fatalError()
                    }
                    header.setup(with: "Tags")
                    return header
                } else {
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NoteHeader.identifier, for: indexPath) as? NoteHeader else {
                        fatalError()
                    }
                    header.setup(with: "All Notes")
                    return header
                }
            default:
                return nil
            }
            
            
        }
        
        return dataSource
    }()
    
    init(palette: ColorSet) {
        self.contentView = AllNotesView(palette: palette)
        self.palette = palette
        
        self.noteRepository = NotesRepository()
        self.tagsRepository = TagRepository()
        
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
//        self.repository.delegate = self
        self.contentView.delegate = self
        self.contentView.collectionView.dataSource = dataSource
        self.tagsRepository.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        // informa qualquer mudança de texto na search
        contentView.searchController.searchResultsUpdater = self
        contentView.searchController.obscuresBackgroundDuringPresentation = false
        contentView.searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = contentView.searchController
        
        // garante que a search nao vai aparecer quando mudar de view mesmo que ela esteja ativada
        definesPresentationContext = true
        
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(Section.allCases)
        do {
            let viewModels = try tagsRepository.getAllTags()
            let tagItems = viewModels.map({
                Item.tag(tagViewModel: $0)
            })
            snapshot.appendItems(tagItems, toSection: .tags)
            
        } catch  {
            
        }
        
        let notes: [NoteCellViewModel] = [.init(note: NoteDummy(noteID: UUID().uuidString, content: "nota1")), .init(note: NoteDummy(noteID: UUID().uuidString, content: "nota2")), .init(note: NoteDummy(noteID: UUID().uuidString, content: "nota3"))]
        let noteItems = notes.map {
            Item.note(noteViewModel: $0)
        }
        snapshot.appendItems(noteItems, toSection: .text)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    func setupNavigationBar() {
        title = "All Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
        navigationItem.rightBarButtonItems = [contentView.addNoteButton, contentView.settingsButton]
    }
}

extension AllNotesViewController: NoteSmallCellCollectionViewCellDelegate {
    func didTapDelete(for noteViewModel: SmallNoteCellViewModel) {
        print("delete")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NoteSmallCellCollectionViewCell else {
            fatalError()
        }
        
//        cell.setup(with: .init(note: <#T##NoteProtocol#>), colorSet: .classic)
        
        return cell
    }
    
    func didTapShare(for noteViewModel: SmallNoteCellViewModel) {
        print("share")
    }
    
    func didTapEdit(for noteViewModel: SmallNoteCellViewModel) {
        print("edit")
    }
}

extension AllNotesViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
  }
}

private extension AllNotesViewController {
    private enum Section: CaseIterable {
        case tags
        case text
    }
    
    private enum Item: Hashable {
        case tag (tagViewModel: TagCellViewModel)
        case note (noteViewModel: NoteCellViewModel)
    }
}

extension AllNotesViewController: AllNotesViewDelegate {
    func didTapSettings() {
        
    }
    
    func didTapAddNote() {
        var snapshot = dataSource.snapshot()
        let notes: [NoteCellViewModel] = [.init(note: NoteDummy(noteID: UUID().uuidString, content: "nota1"))]
        let noteItems = notes.map {
            Item.note(noteViewModel: $0)
        }
        snapshot.appendItems(noteItems, toSection: .text)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension AllNotesViewController: TagRepositoryDelegate {
    func insertTag(_ tag: TagCellViewModel) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([.tag(tagViewModel: tag)], toSection: .tags)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func deleteTag(_ tag: TagCellViewModel) {
        var snapshot = dataSource.snapshot()
        guard let item = snapshot.itemIdentifiers(inSection: .tags).filter({
            switch $0 {
            case .tag(tagViewModel: let viewModel):
                return viewModel.tag.tagID == tag.tag.tagID
                
            case .note(noteViewModel: _):
                return false
            }
        }).first else { return }
        
        snapshot.deleteItems([item])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
