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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NoteCollectionViewCell else {
            fatalError("Cell configured imrpropely")
        }
        cell.setup(colorPalette: ColorSet.classic.palette(), title: "Um grande titulo", content: "From my understanding, this uses already fetched objects to create a fetch request. Which seems kinda redundant? Also, without initially calling performFetch() on my fetched results controller, it doesn't even know how many sections and rows to display. But after calling it, why would i prefetch everything again? So my question: How can i actually integrate a fetched results controller with data source prefetching?")
        return cell
    }
    
}
