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

extension AllNotesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did end..")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)")
    }
}
