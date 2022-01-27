//
//  AllNotesViewController+UISearchResultsUpdating.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let content = searchController.searchBar.searchTextField.text else {return}
        let filteredNotes = noteRepository.filterForContent(content)
        var sectionSnapshot = dataSource.snapshot()
        
        sectionSnapshot.deleteSections([.text])
        sectionSnapshot.appendSections([.text])
        let filteredItems = filteredNotes.map { cellViewModel in
            Item.note(noteViewModel: cellViewModel)
        }
        sectionSnapshot.appendItems(filteredItems, toSection: .text)
        dataSource.apply(sectionSnapshot, animatingDifferences: false)
        
    }
}
