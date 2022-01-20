//
//  NoteViewController+NoteRepositoryProtocolDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension NoteViewController: NoteRepositoryProtocolDelegate {
    func insertNote(_ note: NoteCellViewModel, at indexPath: IndexPath) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([note], toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
        contentView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func deleteNote(_ note: NoteCellViewModel) {
        var snapshot = dataSource.snapshot()
        
        guard let viewModel = snapshot.itemIdentifiers.filter({ note.note.noteID == $0.note.noteID }).first
        else {
            return
        }
        
        snapshot.deleteItems([viewModel])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
