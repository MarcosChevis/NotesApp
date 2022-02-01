//
//  NoteViewController+DataSourceHelpers.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension NoteViewController {
    enum Section {
        case main
    }
    
    typealias NoteDataSource = UICollectionViewDiffableDataSource<Section, NoteCellViewModel>
    typealias NoteCellRegistration = UICollectionView.CellRegistration<NoteCollectionViewCell, NoteCellViewModel>
    
    func makeNoteCellRegistration() -> NoteCellRegistration {
        NoteCellRegistration { [weak self] cell, indexPath, note in
            guard let self = self else { return }
            cell.delegate = self
            cell.setup(palette: self.palette, viewModel: note)
        }
    }
    
    func makeDatasource(with noteCellRegistration: NoteCellRegistration, for collectionView: UICollectionView) -> NoteDataSource {
        NoteDataSource(collectionView: collectionView) { collectionView, indexPath, viewModel in
            collectionView.dequeueConfiguredReusableCell(using: noteCellRegistration, for: indexPath, item: viewModel)
        }
    }
}
