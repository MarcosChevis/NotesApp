//
//  AllNotesViewController.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import UIKit

class AllNotesViewController: ThemableViewController {
    
    var contentView: AllNotesView
    let tagsRepository: TagRepositoryProtocol
    let noteRepository: NotesRepositoryProtocol
    weak var coordinator: AllNotesCoordinatorProtocol?
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        let noteCellRegistration: NoteCellRegistration = makeNoteCellRegistration()
        let tagCellRegistration: TagCellRegistration = makeTagCellRegistration()
        
        let dataSource = makeDataSource(tagCellRegistration: tagCellRegistration, noteCellRegistration: noteCellRegistration)
        
        dataSource.supplementaryViewProvider = makeSupplementaryViewProvider()
        
        return dataSource
    }()
    
    init(palette: CustomColorSet,
         noteRepository: NotesRepositoryProtocol = NotesRepository(isAscending: false),
         tagRepository: TagRepositoryProtocol = TagRepository(),
         notificationService: NotificationService = NotificationCenter.default,
         settings: Settings = Settings()) {
        
        self.contentView = AllNotesView(palette: palette)
        
        self.noteRepository = noteRepository
        self.tagsRepository = tagRepository
        
        super.init(palette: palette, notificationService: notificationService, settings: settings)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupBindings() {
        super.setupBindings()
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
        dataSource.sectionSnapshotHandlers.shouldCollapseItem = { item in return true }
    }
    
    private func setupInitialData() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(Section.allCases)
        
        do {
            let tagItems = try fetchTagData()
            snapshot.appendItems(tagItems, toSection: .tags)
            
            let noteItems = try fetchNoteData()
            snapshot.appendItems(noteItems, toSection: .text)
            
        } catch {
            presentErrorAlert(with: "An error ocurred fetching your notes!")
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
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
        navigationItem.rightBarButtonItems = [ contentView.settingsButton]
        navigationItem.leftBarButtonItem = contentView.closeButton
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
    override func setColors(palette: CustomColorSet) {
        super.setColors(palette: palette)
        contentView.collectionView.reloadData()
    }
}
