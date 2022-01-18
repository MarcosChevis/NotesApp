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
    
//    private let repository: AllNotesRepositoryProtocol
    
    init(palette: ColorSet) {
        self.contentView = AllNotesView(palette: palette)
        self.palette = palette
        
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
        let tags: [TagCellViewModel] = [.init(tag: TagDummy(name: "#tottinene", tagID: UUID().uuidString)), .init(tag: TagDummy(name: "#joshnene", tagID: UUID().uuidString)), .init(tag: TagDummy(name: "#jessienene", tagID: UUID().uuidString))]
        let tagItem = tags.map {
            Item.tag(tagViewModel: $0)
        }
        snapshot.appendItems(tagItem, toSection: .tags)
        
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

class TagDummy: TagProtocol {
    var name: String?
    var tagID: String
    
    init(name: String? = nil, tagID: String) {
        self.name = name
        self.tagID = tagID
    }
}

class NoteDummy: NoteProtocol {
    var noteID: String
    var content: String?
    
    init(noteID: String, content: String? = nil) {
        self.noteID = noteID
        self.content = content
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
