//
//  AllNotesDataSource.swift
//  NotesApp
//
//  Created by Rebecca Mello on 14/01/22.
//

import Foundation
import UIKit
import CoreData

class AllNotesDataSource: NSObject, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
                fatalError()
            }
            cell.setup(with: .init(palette: .classic, tag: "#teste"))
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteSmallCellCollectionViewCell.identifier, for: indexPath) as? NoteSmallCellCollectionViewCell else {
                fatalError()
            }
            cell.setup(with: .init(palette: .classic, title: "Oi", content: "ashcasodha"))
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
    }
}
