//
//  AllNotesViewController+DataSourceHelpers.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController {
    enum Section: CaseIterable {
        case tags
        case text
    }
    
    enum Item: Hashable {
        case tag (tagViewModel: TagCellViewModel)
        case note (noteViewModel: NoteCellViewModel)
    }
    
    typealias TagCellRegistration = UICollectionView.CellRegistration<TagCollectionViewCell, TagCellViewModel>
    typealias NoteCellRegistration = UICollectionView.CellRegistration<NoteSmallCellCollectionViewCell, NoteCellViewModel>
    typealias AllNotesDataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    func makeSupplementaryViewProvider() -> UICollectionViewDiffableDataSource<Section, Item>.SupplementaryViewProvider? {
        
        return { [weak self] (collectionView: UICollectionView,
                  kind: String,
                  indexPath: IndexPath) -> UICollectionReusableView? in
            let textColor = self?.palette.palette().largeTitle ?? ColorSet.classic.palette().largeTitle
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                if indexPath.section == 0 {
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {
                        fatalError()
                    }
                    header.setup(with: "Tags", color: textColor)
                    return header
                } else {
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier, for: indexPath) as? Header else {
                        fatalError()
                    }
                    header.setup(with: "All Notes", color: textColor)
                    return header
                }
            default:
                return nil
            }
        }
    }
    
    func makeTagCellRegistration() -> TagCellRegistration {
        return TagCellRegistration { [weak self] cell, indexPath, tag in
            let palette = self?.palette ?? .classic
            cell.setup(with: tag, colorSet: palette)
        }
    }
    
    func makeNoteCellRegistration() -> NoteCellRegistration {
        return NoteCellRegistration { [weak self] cell, indexPath, note in
            let palette = self?.palette ?? .classic
            cell.delegate = self
            cell.setup(palette: palette, viewModel: note)
        }
    }
    
    func makeDataSource(tagCellRegistration: TagCellRegistration, noteCellRegistration: NoteCellRegistration) -> AllNotesDataSource {
        
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
    
    func insertItem(_ item: Item, at section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([item], toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func deleteItem(_ item: Item, at section: Section) {
        var snapshot = dataSource.snapshot()
        let id = getItemID(item)
        guard let item = findUniqueItemByID(snapshot.itemIdentifiers(inSection: section), id: id) else { return }
        
        snapshot.deleteItems([item])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func findUniqueItemByID(_ items: [Item], id: String) -> Item? {
        items.filter({
            switch $0 {
            case .tag(tagViewModel: let viewModel):
                return viewModel.tag.tagID == id
                
            case .note(noteViewModel: let viewModel):
                return viewModel.note.noteID == id
            }
        }).first
    }
    
    func getItemID(_ item: Item) -> String {
        switch item {
        case .tag(let tagViewModel):
            return tagViewModel.tag.tagID
        case .note(let noteViewModel):
            return noteViewModel.note.noteID
        }
    }
}
