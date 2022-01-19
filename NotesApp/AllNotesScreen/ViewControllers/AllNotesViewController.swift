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
        let noteCellRegistration: NoteCellRegistration = makeNoteCellRegistration()
        let tagCellRegistration: TagCellRegistration = makeTagCellRegistration()
        
        let dataSource = makeDataSource(tagCellRegistration: tagCellRegistration, noteCellRegistration: noteCellRegistration)
        
        dataSource.supplementaryViewProvider = makeSupplementaryViewProvider()
        
        return dataSource
    }()
    
    init(palette: ColorSet,
         noteRepository: NotesRepositoryProtocol = NotesRepository(),
         tagRepository: TagRepositoryProtocol = TagRepository()) {
        
        self.contentView = AllNotesView(palette: palette)
        self.palette = palette
        
        self.noteRepository = noteRepository
        self.tagsRepository = tagRepository
        
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        self.contentView.delegate = self
        self.contentView.collectionView.dataSource = dataSource
        self.tagsRepository.delegate = self
        self.noteRepository.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchController()
        setupInitialData()
    }
    
    private func setupInitialData() {
        do {
            var snapshot = dataSource.snapshot()
            snapshot.appendSections(Section.allCases)
            
            let tagItems = try fetchTagData()
            snapshot.appendItems(tagItems, toSection: .tags)
            
            let noteItems = try fetchNoteData()
            snapshot.appendItems(noteItems, toSection: .text)
            
            dataSource.apply(snapshot, animatingDifferences: false)
        } catch {
            #warning("Implementar mensagem de erro")
        }
    }
    
    private func fetchTagData() throws -> [Item] {
        let viewModels = try tagsRepository.getAllTags()
        let tagItems = viewModels.map({
            Item.tag(tagViewModel: $0)
        })
        
        return tagItems
    }
    
    private func fetchNoteData() throws -> [Item] {
        let notes: [NoteCellViewModel] = try noteRepository.getInitialData()
        let noteItems = notes.map {
            Item.note(noteViewModel: $0)
        }
        
        return noteItems
    }
    
    private func setupNavigationBar() {
        title = "All Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
        navigationItem.rightBarButtonItems = [contentView.addNoteButton, contentView.settingsButton]
    }
    
    private func setupSearchController() {
        // informa qualquer mudança de texto na search
        contentView.searchController.searchResultsUpdater = self
        contentView.searchController.obscuresBackgroundDuringPresentation = false
        contentView.searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = contentView.searchController
        
        // garante que a search nao vai aparecer quando mudar de view mesmo que ela esteja ativada
        definesPresentationContext = true
    }
}

extension AllNotesViewController: NoteSmallCellCollectionViewCellDelegate {
    func didTapDelete(for noteViewModel: NoteCellViewModel) {
        deleteNote(noteViewModel)
    }
    
    func didTapShare(for noteViewModel: NoteCellViewModel) {
        print("share")
    }
    
    func didTapEdit(for noteViewModel: NoteCellViewModel) {
        print("edit")
    }
}

extension AllNotesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        #warning("Fazer a acao do update")
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
        do {
            _ = try noteRepository.createEmptyNote()
            
        } catch {
            print("erro")
            #warning("fazer o erro")
        }
    }
}

extension AllNotesViewController: TagRepositoryDelegate {
    func insertTag(_ tag: TagCellViewModel) {
        insertItem(.tag(tagViewModel: tag), at: .tags)
    }
    
    func deleteTag(_ tag: TagCellViewModel) {
        deleteItem(.tag(tagViewModel: tag), at: .tags)
    }
}

private extension AllNotesViewController {
    private typealias TagCellRegistration = UICollectionView.CellRegistration<TagCollectionViewCell, TagCellViewModel>
    private typealias NoteCellRegistration = UICollectionView.CellRegistration<NoteSmallCellCollectionViewCell, NoteCellViewModel>
    private typealias AllNotesDataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    private func makeSupplementaryViewProvider() -> UICollectionViewDiffableDataSource<Section, Item>.SupplementaryViewProvider? {
        
        return { (collectionView: UICollectionView,
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
    }
    
    private func makeTagCellRegistration() -> TagCellRegistration {
        return TagCellRegistration { cell, indexPath, tag in
            cell.setup(with: tag, colorSet: .classic)
        }
    }
    
    private func makeNoteCellRegistration() -> NoteCellRegistration {
        return NoteCellRegistration { [weak self] cell, indexPath, note in
            cell.delegate = self
            cell.setup(with: note, colorSet: .classic)
        }
    }
    
    private func makeDataSource(tagCellRegistration: TagCellRegistration, noteCellRegistration: NoteCellRegistration) -> AllNotesDataSource {
        
        return AllNotesDataSource(collectionView: contentView.collectionView)
        { collectionView, indexPath, item in
            switch item {
            case .tag(let tagViewModel):
                return collectionView.dequeueConfiguredReusableCell(using: tagCellRegistration, for: indexPath, item: tagViewModel)
                
            case .note(let noteViewModel):
                return collectionView.dequeueConfiguredReusableCell(using: noteCellRegistration, for: indexPath, item: noteViewModel)
            }
        }
    }
}

extension AllNotesViewController: NoteRepositoryProtocolDelegate {
    func insertNote(_ note: NoteCellViewModel, at indexPath: IndexPath) {
        insertItem(.note(noteViewModel: note), at: .text)
    }
    
    func deleteNote(_ note: NoteCellViewModel) {
        deleteItem(.note(noteViewModel: note), at: .text)
    }
}

private extension AllNotesViewController {
    private func insertItem(_ item: Item, at section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([item], toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func deleteItem(_ item: Item, at section: Section) {
        var snapshot = dataSource.snapshot()
        let id = getItemID(item)
        guard let item = findUniqueItemByID(snapshot.itemIdentifiers(inSection: section), id: id) else { return }
        
        snapshot.deleteItems([item])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func findUniqueItemByID(_ items: [Item], id: String) -> Item? {
        items.filter({
            switch $0 {
            case .tag(tagViewModel: let viewModel):
                return viewModel.tag.tagID == id
                
            case .note(noteViewModel: let viewModel):
                return viewModel.note.noteID == id
            }
        }).first
    }
    
    private func getItemID(_ item: Item) -> String {
        switch item {
        case .tag(let tagViewModel):
            return tagViewModel.tag.tagID
        case .note(let noteViewModel):
            return noteViewModel.note.noteID
        }
    }
}
