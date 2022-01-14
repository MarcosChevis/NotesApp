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
    
    init(palette: ColorSet) {
        self.contentView = AllNotesView(palette: palette)
        self.palette = palette
//        self.collectionViewDataSource = self
        
        super.init(nibName: nil, bundle: nil)
        
//        self.contentView.collectionView.dataSource = collectionViewDataSource
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
        
        // informa qualquer mudança de texto na search
        contentView.searchController.searchResultsUpdater = self
        contentView.searchController.obscuresBackgroundDuringPresentation = false
        contentView.searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = contentView.searchController
        
        // garante que a search nao vai aparecer quando mudar de view mesmo que ela esteja ativada 
        definesPresentationContext = true

    }
    
    func setupNavigationBar() {
        title = "All Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
        navigationItem.rightBarButtonItems = [contentView.addNoteButton, contentView.settingsButton]
    }
}

extension AllNotesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NoteSmallCellCollectionViewCell else {
            fatalError()
        }
        
        cell.setup(with: .init(colorSet: .classic, title: "Um Grande titulo", content: "I have a dream that one day every valley shall be engulfed, every hill shall be exalted and every mountain shall…"))
        return cell
    }
}

extension AllNotesViewController: NoteSmallCellCollectionViewCellDelegate {
    func didTapDelete(for noteViewModel: SmallNoteCellViewModel) {
        print("delete")
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
