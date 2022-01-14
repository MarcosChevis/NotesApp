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
    var collectionDataSource: AllNotesDataSource
    
    init(palette: ColorSet, collectionDataSource: AllNotesDataSource) {
        self.contentView = AllNotesView(palette: palette)
        self.palette = palette
        self.collectionDataSource = collectionDataSource
        
        super.init(nibName: nil, bundle: nil)
        
        self.contentView.collectionView.dataSource = collectionDataSource
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

//extension AllNotesViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 6
//        } else {
//            return 10
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
//                fatalError()
//            }
//            cell.setup(with: .init(colorSet: .classic, tag: "#teste"))
//            return cell
//        } else {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteSmallCellCollectionViewCell.identifier, for: indexPath) as? NoteSmallCellCollectionViewCell else {
//                fatalError()
//            }
//            cell.setup(with: .init(colorSet: .classic, title: "Oi", content: "ashcasodha"))
//            return cell
//        }
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if indexPath.section == 0 {
//            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TagHeader.identifier, for: indexPath) as? TagHeader else {
//                fatalError()
//            }
//            header.setup(with: "Tags")
//            return header
//        } else {
//            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NoteHeader.identifier, for: indexPath) as? NoteHeader else {
//                fatalError()
//            }
//            header.setup(with: "All Notes")
//            return header
//        }
//    }
//}

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
