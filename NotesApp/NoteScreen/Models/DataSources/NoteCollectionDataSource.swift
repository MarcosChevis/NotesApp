//
//  NoteCollectionDataSource.swift
//  NotesApp
//
//  Created by Caroline Taus on 12/01/22.
//

import Foundation
import UIKit
import CoreData

class NoteCollectionDataSource: NSObject, NoteCollectionDataSourceProtocol, NSFetchedResultsControllerDelegate {
    
    let repository: NotesRepository
    weak var delegate: NoteCollectionDataSourceDelegate?
    
    init(repository: NotesRepository) {
        self.repository = repository
        super.init()
        repository.fetchResultsController.delegate = self
    }
    
    func setupFetching() throws {
        try repository.fetchResultsController.performFetch()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repository.numberOfElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.identifier, for: indexPath) as? NoteCollectionViewCell else {
            fatalError("Cell configured imrpropely")
        }
        
        let note = repository.fetchResultsController.object(at: indexPath)
        let viewModel = NoteCellViewModel(id: note.objectID.uriRepresentation(),
                                          title: "Página \(indexPath.row)",
                                          content: note.content ?? "String Vazia")
        
        cell.setup(colorPalette: ColorSet.classic.palette(),
                   title: viewModel.title,
                   content: viewModel.content)
        
        return cell
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            handleCoreDataInsert(at: newIndexPath)
        case .delete:
            handleCoreDataDelete(at: indexPath)
        case .move:
            break
        case .update:
            handleCoreDataUpdate(at: indexPath)
        @unknown default:
            break
        }
    }
    
    private func handleCoreDataUpdate(at indexPath: IndexPath?) {
        guard let indexPath = indexPath,
              let viewModel = buildCellViewModel(for: indexPath)
        else {
            return
        }
        delegate?.updateItem(viewModel, at: indexPath)
    }
    
    private func handleCoreDataInsert(at indexPath: IndexPath?) {
        guard
            let indexPath = indexPath,
            let viewModel = buildCellViewModel(for: indexPath),
            repository.generatePermanentsIds() == true
        else {
            return
        }
        
        delegate?.insertItem(viewModel, at: indexPath)
    }
    
    private func handleCoreDataDelete(at indexPath: IndexPath?) {
        guard
            let indexPath = indexPath
        else {
            return
        }
        delegate?.deleteItem(at: indexPath)
    }
    
    private func buildCellViewModel(for indexPath: IndexPath) -> NoteCellViewModel? {
        let note = repository.fetchResultsController.object(at: indexPath)
        
        guard let content = note.content else {
            return nil
        }
        
        repository.generatePermanentsIds()
        
        return NoteCellViewModel(id: note.objectID.uriRepresentation(), title: "Página \(indexPath.row)", content: content)
    }
    
    func addItem(_ viewModel: NoteCellViewModel) throws {
        try repository.addNote(content: viewModel.content)
    }
    
    func removeItem(_ viewModel: NoteCellViewModel) throws {
        guard let id = viewModel.id else {
            throw NoteRepositoryError.noObjectForID
        }
        
        try repository.deleteNote(id)
    }
    
    func editNote(_ viewModel: NoteCellViewModel) throws {
        try repository.editNote(with: viewModel)
    }
    
}

protocol NoteCollectionDataSourceProtocol: NSObject, UICollectionViewDataSource {
    func setupFetching() throws
    func addItem(_ viewModel: NoteCellViewModel) throws
    func removeItem(_ viewModel: NoteCellViewModel) throws
    func editNote(_ viewModel: NoteCellViewModel) throws
}


