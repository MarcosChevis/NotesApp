//
//  NoteCollectionDataSource.swift
//  NotesApp
//
//  Created by Caroline Taus on 12/01/22.
//

import Foundation
import UIKit
import CoreData

class NoteCollectionDataSource: NSObject, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colors: [UIColor] = [.magenta, .green, . blue, .brown]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors.randomElement()
        return cell
    }
    
}
